{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.lf = {
    enable = lib.mkEnableOption "Enables lf file manager";
  };
  config = lib.mkIf config.modules.lf.enable {
    programs.lf = {
      enable = true;
    };
  };
}
