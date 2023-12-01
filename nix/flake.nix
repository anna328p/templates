{
	description = "TODO";

	inputs = {
		# nixpkgs.url = github:nixos/nixpkgs;
	};

	outputs = { self
		, nixpkgs
		, flake-utils
	}: let
		inherit (nixpkgs.lib) genAttrs systems;

		# forEachSystem' : (Str -> Set Any) -> (Set Any -> Set Any) -> Set (Set Any)
		forEachSystem' = env: body:
			genAttrs (system: body (env system)) systems.flakeExposed;

		env = system: rec {
			inherit system;
			pkgs = nixpkgs.legacyPackages.${system};

			pkgName = "TODO";

			pkg = pkgs.callPackage ./default.nix { };
		};

		forEachSystem = forEachSystem' env;

	in {
		packages = forEachSystem (env: let
			inherit (env) pkgName pkg;
		in {
			${pkgName} = pkg;
			default = pkg;
		});

		devShells = forEachSystem (env: let
			inherit (env) pkgName pkgs pkg;

			shell = import ./shell.nix { inherit pkgs pkg; };
		in {
			${pkgName} = shell;
			default = shell;
		});
	};
}
