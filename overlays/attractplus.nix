attractplus-src: final: prev:
{
  attractplus = prev.stdenv.mkDerivation rec {
    pname = "attractplus";
    version = "3.2.0";

    src = attractplus-src;

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
    ];

    # The Makefile uses cmake for internal SFML, but we want to use the Makefile
    # for the main project.
    dontUseCmakeConfigure = true;

    makeFlags = [
      "USE_DRM=1"
      "USE_GLES=1"
      "STATIC=1"
      "USE_SYSTEM_SFML=0"
      "prefix=$(out)"
    ];

    enableParallelBuilding = true;

    # The Makefile's install target copies the executable to /bin and
    # resources to /share/attractplus.
    preInstall = ''
      mkdir -p $out/bin
      mkdir -p $out/share/attractplus
    '';
  };
}
