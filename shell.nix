with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    bash
    nix-repl
    nixops
    disnix
  ];
  shellHook = ''
    echo Hello ChamberConf!
  '';
}
