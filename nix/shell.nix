{ pkgs ? import <nixpkgs> { }
, specialArgs ? { }
, pkg ? pkgs.callPackage ./. specialArgs
}:

(pkg.override { }).overrideAttrs (attrs: { })
