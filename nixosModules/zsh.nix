{
  config,
  lib,
  pkgs,
  ...
}: {
  options = {
    modules.zsh.enable = lib.mkEnableOption "Enable zsh";
  };
  config = lib.mkIf config.modules.zsh.enable {
    programs.zsh.enable = true;
    users.users.whoselow.shell = pkgs.zsh;
  };
}
