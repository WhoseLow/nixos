{
  pkgs,
  config,
  ...
}: {
  config.stylix = {
    enable = true;
    base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
    fonts = {
      monospace = {
        package = pkgs.nerd-fonts.roboto-mono;
        name = "RobotoMono Nerd Font";
      };
    };
    opacity = {
      applications = 0.75;
      terminal = 0.75;
    };
  };
}
