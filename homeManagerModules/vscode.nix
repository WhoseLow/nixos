{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.vscode = {
    enable = lib.mkEnableOption "Vscodium";
  };
  config = lib.mkIf config.modules.vscode.enable {
    programs.vscode = {
      enable = true;
      package = pkgs.vscodium;
      profiles.default = {
        extensions = with pkgs.vscode-extensions; [
          vscodevim.vim
          streetsidesoftware.code-spell-checker
        ];
      };
    };
  };
}
