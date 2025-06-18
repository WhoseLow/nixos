{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.thunar = {
    enable = lib.mkEnableOption "Thunar File Manager";
  };
  config = lib.mkIf config.modules.thunar.enable {
    programs.thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
      ];
    };
    # Thumbnail Support
    services.tumbler.enable = true;
  };
}
