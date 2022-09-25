{ pkgs ? import <nixpkgs> { } }:

(pkgs.callPackage ./. { }).overrideAttrs (attrs: { })
