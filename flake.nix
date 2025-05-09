{
  description = "Flutter Development Environment";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.11";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs = { self, nixpkgs, flake-utils, ... }:
    flake-utils.lib.eachDefaultSystem (system: let
      pkgs = import nixpkgs { inherit system; };
      lib = pkgs.lib;
    in 
    rec {
      devShell = pkgs.mkShell {
        buildInputs = with pkgs; [
          flutter
          yq
          clang
          cmake
          dart
          dpkg
          flutter
          git
          gnome.zenity
          gtk3
          ninja
          patchelf
          pcre2
          plocate
          pkg-config
          rpm
        ];

        FLUTTER_ROOT = pkgs.flutter;
        DART_ROOT = "${pkgs.flutter}/bin/cache/dart-sdk";
        LD_LIBRARY_PATH = "${pkgs.lib.makeLibraryPath [ pkgs.vulkan-loader pkgs.libGL ]}";

        shellHook = ''
          flutter pub get
          flutter config --enable-linux-desktop
          flutter config --enable-web
          flutter config --no-enable-android
          dart pub global activate flutter_distributor
          echo "**********************************************************************"
          echo "* flutter build linux --release                                      *"
          echo "* flutter_distributor package --platform=linux --targets=zip         *"
          echo "**********************************************************************"
          if [ -z "$PUB_CACHE" ]; then
            export PATH="$PATH":"$HOME/.pub-cache/bin"
          else
            export PATH="$PATH":"$PUB_CACHE/bin"
          fi
        '';
      };

      packages = {
        innokalb-demo-web = pkgs.flutter.buildFlutterApplication rec {
          pname = "innokalb-demo-web";
          version = "0.1.0";
          targetFlutterPlatform = "web";
          src = ./.;
          pubspecLock = lib.importJSON ./pubspec.lock.json;
        };
      };
      defaultPackage = packages.innokalb-demo-web;
    });
}