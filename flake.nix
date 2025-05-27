{
  description = "WhoseLow's NixOS Config";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    stylix.url = "github:danth/stylix";

    nvf.url = "github:notashelf/nvf";
  };

  outputs = {
    nixpkgs,
    home-manager,
    stylix,
    nvf,
    self,
    ...
  } @ inputs: {
    nixosConfigurations = {
      nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/nixos/configuration.nix
          home-manager.nixosModules.default
          stylix.nixosModules.stylix

          # NVF module
          ({pkgs, ...}: {
            environment.systemPackages = [
              self.packages.${pkgs.stdenv.system}.my-neovim
            ];
          })
        ];
      };
    };
    packages.x86_64-linux.my-neovim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./nvf_module.nix
        ];
      }).neovim;
  };
}
