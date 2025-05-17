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

      settings = {};
    };
  };
}
