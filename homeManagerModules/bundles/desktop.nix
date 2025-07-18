{
  pkgs,
  lib,
  config,
  ...
}: {
  options.bundles.desktop = {
    enable = lib.mkEnableOption "Graphical Desktop and associated apps";
  };
  config = lib.mkIf config.bundles.desktop.enable {
    modules = {
      hyprland.enable = lib.mkDefault true;
      alacritty.enable = lib.mkDefault true;
      zsh.enable = lib.mkDefault true;
      zen-browser.enable = lib.mkDefault true;
    };

    home.packages = with pkgs; [
      feh
      lm_sensors
      onlyoffice-bin
      easyeffects
      mpv
    ];
  };
}
