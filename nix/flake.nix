{
	description = "TODO";

	inputs = {
		# nixpkgs.url = github:nixos/nixpkgs;

		flake-utils.url = github:numtide/flake-utils;
	};

	outputs = { self
		, nixpkgs
		, flake-utils
	}: flake-utils.lib.eachDefaultSystem (system: let
		pkgs = nixpkgs.legacyPackages.${system};
		
		pkgName = "TODO";

		pkg = pkgs.callPackage ./default.nix { };
		shell = import ./shell.nix { inherit pkgs; };
	in {
		packages.${pkgName} = pkg;
		packages.default = pkg;

		devShells.${pkgName} = shell;
		devShells.default = shell;
	});
}
