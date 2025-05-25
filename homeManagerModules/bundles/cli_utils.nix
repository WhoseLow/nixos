{
  pkgs,
  lib,
  config,
  ...
}: {
  options.bundles.cli_utils = {
    enable = lib.mkEnableOption "cli tools";
  };
  config = lib.mkIf config.bundles.desktop.enable {
    home.packages = with pkgs; [
      htop
      unzip
      neovim
      git
      wget
      nh
      tealdeer
      neofetch
    ];
  };
}
