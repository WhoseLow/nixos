{
  lib,
  config,
  ...
}: {
  options.modules.waybar = {
    enable = lib.mkEnableOption "Enable waybar";
  };
  config = lib.mkIf config.modules.waybar.enable {
    programs.waybar = {
      enable = true;

      settings = [
        {
          modules-left = [
            "hyprland/workspaces"
          ];
          modules-center = [
            "hyprland/window"
          ];
          modules-right = [
            "tray"
            "cpu"
            "memory"
            "clock"
          ];

          tray = {
            icon-size = 13;
            tooltip = false;
            spacing = 10;
          };
          cpu = {
            interval = 10;
            format = " {}%";
            max-length = 10;
            on-click = "";
          };
          memory = {
            interval = 30;
            format = " {}%";
            format-alt = " {used:0.1f}G";
            max-length = 10;
          };
          clock = {
            format = " {:%I:%M %p   %m/%d} ";
            tooltip-format = ''
              <big>{:%Y %B}</big>
              <tt><small>{calendar}</small></tt>'';
          };
        }
      ];
    };
  };
}
