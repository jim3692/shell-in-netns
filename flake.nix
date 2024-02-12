{
  description = "Shell in network namespace";

  outputs = { self, nixpkgs, }:
    let
      pkgsFor = nixpkgs.legacyPackages;
      systems = [ "aarch64-linux" "i686-linux" "x86_64-linux" ];
      forAllSystems = nixpkgs.lib.genAttrs systems;
      mkDate = longDate:
        with builtins;
        (concatStringsSep "-" [
          (substring 0 4 longDate)
          (substring 4 2 longDate)
          (substring 6 2 longDate)
        ]);
    in {
      packages = forAllSystems (system: {
        default = with pkgsFor.${system};
          stdenv.mkDerivation {
            name = "shell-in-netns";
            version = mkDate (self.lastModifiedDate or "19700101") + "_"
              + (self.shortRev or "dirty");

            src = self;

            installPhase = ''
              runHook preInstall

              # Install files
              mkdir -p $out/bin
              install -Dm755 create-ns.sh $out/bin/create-ns

              runHook postInstall
            '';
          };
      });
    };
}
