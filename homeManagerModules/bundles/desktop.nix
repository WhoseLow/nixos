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
    };
    home.packages = with pkgs; [
      floorp
      xfce.thunar

      feh
      mpv
      lm_sensors
      onlyoffice-bin
      easyeffects
    ];
  };
}
