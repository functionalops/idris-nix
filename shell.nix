{ pkgs ? import <nixpkgs> {}
, hscompiler ? "ghc7102"
, ... }:
let

  inherit (pkgs) stdenv erlang nix;

  hsenv   = pkgs.pkgs.haskell;
  hspkgsF = p: with p; [
    cabal-install
    doctest
    optparse-applicative
    idris
  ];
  ghc = hsenv.packages.${hscompiler}.ghcWithPackages hspkgsF;

in
stdenv.mkDerivation {
  name = "idris-nix";
  buildInputs = [
    ghc
    erlang
  ];

  shellHook = ''
    eval $(grep export ${ghc}/bin/ghc)
  '';
}
