{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
in {
  options.modules.hyprland.monitors = mkOption {
    type = types.anything;
    default = [
      ",preferred,auto,auto"
    ];
  };
  config = {
    wayland.windowManager.hyprland.settings = {
      monitor = config.modules.hyprland.monitors;
    };
  };
}
