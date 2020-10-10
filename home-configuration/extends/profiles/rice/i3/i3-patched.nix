{ fetchurl, stdenv, i3, autoreconfHook }:

i3.overrideAttrs (
  oldAttrs: rec {
    name = "i3-gaps-patched-${version}";
    version = "4.15.0.1";
    releaseDate = "2018-03-13";

    src = fetchurl {
      url = "https://github.com/max-lv/i3/archive/${version}.tar.gz";
      sha256 = "sha256-VDmYwMwqf37H3+hJvIXLrbRCziKG8016/EN6NG1cRps=";
    };

    nativeBuildInputs = oldAttrs.nativeBuildInputs ++ [ autoreconfHook ];

    postUnpack = ''
      echo -n "${version} (${releaseDate})" > ./i3-${version}/I3_VERSION
    '';

    enableParallelBuilding = false;
  }
)
