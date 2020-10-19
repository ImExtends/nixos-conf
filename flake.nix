{
  description =
    "Flake (unstable) that manages my system configuration, replacement to niv.";

  inputs = {
    stable.url = "nixpkgs/nixos-20.09";
    unstable.url = "nixpkgs/nixpkgs-unstable";
    master.url = "nixpkgs/master";

    manix.url = "github:mlvzk/manix";

    home = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "stable";
    };

    nur.url = "github:ImExtends/NUR";
    nur.inputs.nixpkgs.follows = "stable";

    hardware.url = "github:NixOS/nixos-hardware/master";
  };

  outputs = inputs:
    with builtins;
    let
      channels = with inputs; {
        pkgs = unstable;
        lib = unstable;
      };
      config = { allowUnfree = true; };

      systems = [ "x86_64-linux" "i686-linux" "x86_64-darwin" "aarch64-linux" ];
      forAllSystems = f:
        lib.genAttrs systems (
          system: f { inherit system; }
        );

      diffTrace = left: right: string: value:
        if left != right then trace string value else value;

      inherit (channels.lib) lib;
      inherit (inputs.home.nixosModules) home-manager;

      homeUsers = {
        Extends = {
          system = lib.elemAt systems 0;
          config = ./home-configuration/extends/home.nix;
          username = "extends";
          homeDirectory = "/home/extends";
        };
      };

      mkHomeUsr = { system, config, username, name, homeDirectory }:
        let pkgs = pkgsForSystem system;
        in
        inputs.home.lib.homeManagerConfiguration {
          inherit system pkgs username homeDirectory;
          configuration = { ... }: {
            nixpkgs.config.allowUnfree = true;
            imports = [
              (import config)
            ];
          };
        };

      genHomeUsr = usrs: mkUser: with lib; genAttrs (attrNames usrs) (name: mkUser ({ inherit name; } // usrs.${name}));

      channelToOverlay = { system, config, flake, branch }:
        (
          final: prev: {
            ${flake} = mapAttrs
              (
                k: v:
                  diffTrace (baseNameOf inputs.${flake}) (baseNameOf prev.path)
                    "${k} pinned to nixpkgs/${branch}"
                    v
              )
              (
                import inputs.${flake} {
                  inherit config system;
                  overlays = [ ];
                }
              );
          }
        );

      pkgsForSystem = system:
        import channels.pkgs rec {
          inherit system config;
          overlays = [
            (
              channelToOverlay {
                inherit system config;
                flake = "master";
                branch = "master";
              }
            )
            (
              channelToOverlay {
                inherit system config;
                flake = "stable";
                branch = "nixos-20.03";
              }
            )
          ] ++ [ inputs.nur.overlay ];
        };

    in
    {
      homeConfigurations = genHomeUsr homeUsers mkHomeUsr;
      nixosConfigurations = with lib;
        let
          specialArgs = { inherit inputs; };
          home = { config, ... }: {
            # Temporary solution for homeManagerConfiguration
            options.home-manager.users = lib.mkOption {
              type = lib.types.attrsOf (lib.types.submoduleWith {
                modules = [ ];
                specialArgs = specialArgs // {
                  super = config;
                };
              });
            };

            config = {
              home-manager.useGlobalPkgs = true;
            };
          };

          system = "x86_64-linux";
          pkgs = pkgsForSystem system;

          listHosts = toList (removeSuffix "-hardware.nix" (
            toString (
              filter (hasSuffix ".nix")
                (attrsets.attrNames (builtins.readDir ./hardware-configuration))
            ))
          );

          importFiles = listToAttrs (
            map
              (file: nameValuePair file (toString ./hosts + "/${file}"))
              (attrNames (builtins.readDir ./hosts))
          );

          check = hasAttr "${inputs.self.nixosConfigurations.${hosts}.config.networking.hostName}.nix" (
            filterAttrs (name: _: name != "default.nix") importFiles
          );

          files = import (toString (attrValues (filterAttrs (name: _: name != "default.nix") importFiles)));

          flakeHost = hname: with lib;
            let
              modules = [
                {
                  system.configurationRevision = lib.mkIf (inputs.self ? rev) inputs.self.rev;
                  nix.nixPath = lib.mkForce [
                    "nixpkgs=${channels.pkgs}"
                    "nixos-config=/nixos-conf/default.nix"
                  ];
                  system.extraSystemBuilderCmds =
                    let
                      inp = lib.mapAttrsToList lib.nameValuePair inputs;
                    in
                    ''
                      mkdir -p $out/flake/input

                      ${lib.concatMapStringsSep "\n"
                        ({ name, value }: ''
                          ln -s '${value}' $out/flake/input/${name}
                        '')
                      inp}
                    '';
                  system.activationScripts.etcnixos = ''
                    rm -rf /etc/nixos
                    ln -sfn /run/current-system/flake/input/self /etc/nixos || \
                    true
                  '';
                  nix.registry = lib.mapAttrs
                    (
                      id: flake: {
                        inherit flake;
                        from = {
                          inherit id;
                          type = "indirect";
                        };
                      }
                    )
                    (inputs // { nixpkgs = inputs.master; manix = inputs.manix; });

                  environment.etc.nixpkgs.source = inputs.stable;
                  nixpkgs.pkgs = pkgs;
                }
                ./default.nix
                files
                home
                home-manager
                inputs.stable.nixosModules.notDetected
                inputs.hardware.nixosModules.asus-fx504gd
              ];
            in
            nixosSystem {
              inherit system modules specialArgs;
            };
        in
        genAttrs listHosts flakeHost;
      sigma =
        inputs.self.nixosConfigurations.sigma.config.system.build.toplevel.drvPath;

      devShell = forAllSystems (
        { system, ... }:
        let
          pkgs = import channels.pkgs { inherit system; };
        in
        pkgs.mkShell rec {
          nativeBuildInputs = with pkgs; [ nixpkgs-fmt ];

          NIX_CONF_DIR = with pkgs;
            let
              nixConf = ''
                ${lib.optionalString (builtins.pathExists /etc/nix/nix.conf)
                (builtins.readFile /etc/nix/nix.conf)}
                experimental-features = nix-command flakes ca-references
              '';
            in
            linkFarm "nix-conf-dir" (
              [
                {
                  name = "nix.conf";
                  path = writeText "flakes-nix.conf" nixConf;
                }
                {
                  name = "registry.json";
                  path = /etc/nix/registry.json;
                }
              ]
            );
        }
      );
    };
}
