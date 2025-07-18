{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
with lib; {
  options = {
    modules.hyprland.enable = mkEnableOption "Enable hyprland";
  };

  config = mkIf config.modules.hyprland.enable {
    # UWSM setup, may move to its own module in the future
    programs.uwsm = {
      enable = true;
      # package = inputs.hyprland.packages."${pkgs.system}".hyprland;
      waylandCompositors = {
        hyprland = {
          prettyName = "Hyprland";
          comment = "Hyprland compositor managed by UWSM";
          binPath = "/run/current-system/sw/bin/Hyprland";
        };
      };
    };

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
      withUWSM = true;
    };
  };
}
