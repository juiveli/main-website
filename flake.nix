
{
  description = "Hugo mainpage as a Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs";
  };

  outputs = { self, nixpkgs }: 
  let pkgs = import nixpkgs { system = "x86_64-linux"; };
  in {
    packages.x86_64-linux.hugo-mainsite = pkgs.stdenv.mkDerivation {
      name = "hugo-mainpage";
      src = ./.;
      buildInputs = [ pkgs.hugo ];
      buildPhase = "hugo";
      installPhase = ''
        mkdir -p $out
        cp -r public/* $out/
      '';
    };
    defaultPackage.x86_64-linux = self.packages.x86_64-linux.hugo-mainpage;
  };
}
