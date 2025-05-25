{
  lib,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./starship.nix
  ];
  options.modules.zsh = {
    enable = lib.mkEnableOption "Enable zsh";
  };
  config = lib.mkIf config.modules.zsh.enable {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      dotDir = ".config/zsh";
      history.size = 10000;
      shellAliases = {
        ":q" = "exit";
        "ls" = "eza --icons -a --group-directories-first";
        "tree" = "eza --color=auto --icons --tree";
        "grep" = "grep --color=auto";
      };
    };
    home.packages = with pkgs; [
      eza
    ];
  };
}
