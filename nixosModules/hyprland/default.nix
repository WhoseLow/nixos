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
    environment.systemPackages = with pkgs; [
      waybar
      wofi
      wl-clipboard
      wlogout
    ];

    programs.hyprland = {
      enable = true;
      xwayland.enable = true;
    };
  };
}
