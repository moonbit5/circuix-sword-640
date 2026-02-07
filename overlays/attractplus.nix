final: prev:
{
  attractplus = prev.stdenv.mkDerivation rec {
    pname = "attractplus";
    version = "3.2.0";

    src = prev.fetchgit {
      url = "https://github.com/oomek/attractplus.git";
      rev = "1031a40944bc18e22aca5ff9e04aebbdcb35b4b5";
      sha256 = "sha256-AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA="; # PLACEHOLDER: Update this hash after the first build failure
      fetchSubmodules = true;
    };

    nativeBuildInputs = [
      prev.pkg-config
      prev.cmake
    ];

    buildInputs = [
      prev.ffmpeg
      prev.openal
      prev.libarchive
      prev.libjpeg
      prev.freetype
      prev.fontconfig
      prev.libdrm
      prev.mesa
      prev.libGLU
      prev.curl
      prev.zlib
      prev.udev
      prev.SDL2
      prev.libogg
      prev.libvorbis
      prev.expat
    ];

    # The Makefile uses cmake for internal SFML, but we want to use the Makefile
    # for the main project.
    dontUseCmakeConfigure = true;

    # The fork oomek/attractplus uses attractplus as binary name and resource path
    makeFlags = [
      "USE_DRM=1"
      "USE_GLES=1"
      "STATIC=1"
      "USE_SYSTEM_SFML=0"
      "prefix=$(out)"
    ];

    enableParallelBuilding = true;

    preInstall = ''
      mkdir -p $out/bin
      mkdir -p $out/share/attractplus
    '';

    meta = with prev.lib; {
      description = "Attract-Mode Plus frontend";
      homepage = "https://github.com/oomek/attractplus";
      license = licenses.gpl3Plus;
      platforms = platforms.linux;
    };
  };
}
