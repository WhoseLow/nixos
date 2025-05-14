{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    modules.hyprland.enable = mkEnableOption "Enable hyprland";
  };

  config = mkIf config.modules.hyprland.enable {
    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
