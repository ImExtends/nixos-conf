{ stdenv
, fetchFromGitHub
, meson
, ninja
, pkgconfig
, cmake
, libev
, libX11
, xcbutilrenderutil
, xcbutilimage
, libXext
, pixman
, uthash
, libconfig
, pcre
, libGL
, dbus
}:

stdenv.mkDerivation rec {
  pname = "picom-unstable";
  version = "v8";

  src = fetchFromGitHub {
    owner = "ibhagwan";
    repo = "picom";
    rev = "e553e00f48de67d52fe75de9e0e940d85aa14a24";
    sha256 = "0l7c2wx9y60p2c7bjv3gsgzqfyaql5brsv7ahzqzhhxa76s50anv";
  };

  installFlags = [ "PREFIX=$(out)" ];
  nativeBuildInputs = [ meson ninja pkgconfig cmake uthash ];

  buildInputs = [
    libev
    libX11
    xcbutilrenderutil
    xcbutilimage
    libXext
    pixman
    libconfig
    pcre
    libGL
    dbus
  ];
}
