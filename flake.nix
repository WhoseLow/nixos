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

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
      "desktop" = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/desktop/configuration.nix
          home-manager.nixosModules.default
          stylix.nixosModules.stylix

          # TODO: move to separate module
          ({pkgs, ...}: {
            environment.systemPackages = [
              self.packages.${pkgs.stdenv.system}.nvim
            ];
          })
        ];
      };
    };
    packages.x86_64-linux.nvim =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./packages/nvim
        ];
      }).neovim;

    packages.x86_64-linux.nvim-js =
      (nvf.lib.neovimConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        modules = [
          ./packages/nvim
          ({...}: {
            config.vim.languages.ts.enable = true;
          })
        ];
      }).neovim;
  };
}
