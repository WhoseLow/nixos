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

    modules.hyprland.monitors = [
      "DP-4, highrr, 0x0, 1"
      "DP-6, highrr, auto, 1, transform, 1"
    ];

    bundles = {
      desktop.enable = true;
      gaming.enable = true;
    };

    home = {
      username = "whoselow";
      homeDirectory = "/home/whoselow";
      stateVersion = "24.11";

      packages = with pkgs; [
        obs-studio
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
