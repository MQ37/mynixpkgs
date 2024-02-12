{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-23.11";
    flake-utils.url = "github:numtide/flake-utils";
  };
  outputs = { self, nixpkgs, flake-utils }:
    flake-utils.lib.eachDefaultSystem
      (system:
        let
          pkgs = import nixpkgs {
            inherit system;
          };
        in
        with pkgs;
        {

          mdp-toolkit = pkgs.callPackage ./mdp-toolkit/default.nix 
          {
            pythonOlder = pkgs.lib.versionOlder pkgs.python3.version;
            inherit (pkgs.python3Packages) buildPythonPackage;

            inherit (pkgs.python3Packages) joblib pytest future numpy scikit-learn;
          };

          csharp-ls_8 = pkgs.callPackage ./csharp-ls_8/default.nix 
          {
          };

        }
      );
}
