{
  config,
  pkgs,
  outputs,
  ...
}: {
  # imports = [outputs.homeManagerModules.default];

  imports = [
    ./../../homeManagerModules
  ];

  config = {
    # Git credentials
    programs.git = {
      userName = "WhoseLow";
      userEmail = "whose.low@protonmail.com";
    };

    modules = {
      hyprland.enable = true;
    };

    home = {
      username = "whoselow";
      homeDirectory = "/home/whoselow";
      stateVersion = "24.11";

      packages = [
      ];

      file = {
      };

      sessionVariables = {
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
