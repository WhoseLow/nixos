{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.obsidian = {
    enable = lib.mkEnableOption "Obsidian.md";
  };
  config = lib.mkIf config.modules.obsidian.enable {
    programs.obsidian = {
      enable = true;
      defaultSettings = {
        app = {
          promptDelete = false;
          readableLineLength = false;
          showLineNumber = true;
          vimMode = true;
          alwaysUpdateLinks = true;
          showInlineTitle = false;
        };
        # TODO: Add theming
      };
    };
  };
}
