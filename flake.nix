{
  description = "deslop-please";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    rust-overlay.url = "github:oxalica/rust-overlay";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      nixpkgs,
      rust-overlay,
      flake-utils,
      ...
    }:
    # nixpkgs 26.11 dropped x86_64-darwin, so list the supported systems
    # explicitly rather than using eachDefaultSystem.
    flake-utils.lib.eachSystem
      [
        "x86_64-linux"
        "aarch64-linux"
        "aarch64-darwin"
      ]
      (
        system:
        let
          pkgs = import nixpkgs {
            inherit system;
            overlays = [ (import rust-overlay) ];
          };
          # The lints read rust-analyzer's index, so its version is part of what
          # they report: pinned with the Rust it comes with.
          rustToolchain = pkgs.rust-bin.stable."1.99.0".minimal.override {
            extensions = [
              "rust-src"
              "rust-analyzer"
              "clippy"
              "rustfmt"
            ];
          };
        in
        {
          devShells.default = pkgs.mkShell {
            packages = [ rustToolchain ];
          };
        }
      );
}
