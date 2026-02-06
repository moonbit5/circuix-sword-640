final: prev: {
  pegasus-frontend = final.libsForQt5.callPackage ({ lib, fetchFromGitHub, stdenv, cmake, SDL2, sqlite, qtbase, qtmultimedia, qtsvg, qtgraphicaleffects, qtx11extras, qttools, wrapQtAppsHook }:
    stdenv.mkDerivation {
      pname = "pegasus-frontend";
      version = "unstable-2024-11-11";

      src = fetchFromGitHub {
        owner = "mmatyas";
        repo = "pegasus-frontend";
        rev = "54362976fd4c6260e755178d97e9db51f7a896af";
        fetchSubmodules = true;
        hash = "sha256-DqtkvDg0oQL9hGB+6rNXe3sDBywvnqy9N31xfyl6nbI=";
      };

      nativeBuildInputs = [
        cmake
        qttools
        wrapQtAppsHook
      ];

      buildInputs = [
        qtbase
        qtmultimedia
        qtsvg
        qtgraphicaleffects
        qtx11extras
        sqlite
        SDL2
      ];

      patches = [
        ./pegasus-frontend/kms_launch_fix.patch
      ];

      postPatch = ''
        # Add private headers for EGLFS to CMakeLists.txt
        # These are required by the kms_launch_fix.patch
        sed -i '/target_link_libraries(pegasus-backend PUBLIC/a \    Qt5::Gui_Private\n    Qt5::EglFsDeviceLib_Private' src/backend/CMakeLists.txt
      '';

      cmakeFlags = [
        "-DPEGASUS_BUILD_TESTS=OFF"
      ];

      meta = {
        description = "Cross platform, customizable graphical frontend for launching emulators and managing your game collection";
        mainProgram = "pegasus-fe";
        homepage = "https://pegasus-frontend.org/";
        license = lib.licenses.gpl3Plus;
        platforms = lib.platforms.linux;
      };
    }) {};
}
