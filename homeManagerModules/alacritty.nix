{
  lib,
  config,
  ...
}: {
  options.modules.alacritty = {
    enable = lib.mkEnableOption "Enable alacritty";
  };
  config = lib.mkIf config.modules.alacritty.enable {
    programs.alacritty.enable = true;
  };
}
