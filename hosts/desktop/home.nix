{
  config,
  pkgs,
  outputs,
  ...
}: {
  imports = [
    ./../../homeManagerModules
  ];

  config = {
    # Git credentials
    programs.git = {
      enable = true;
      userName = "WhoseLow";
      userEmail = "whose.low@protonmail.com";
    };

    modules.hyprland.monitors = [
      "DP-4, highrr, 0x0, 1"
      "DP-6, highrr, auto, 1, transform, 1"
    ];

    bundles = {
      cli_utils.enable = true;
      desktop.enable = true;
      gaming.enable = true;
    };

    modules = {
      obs-studio.enable = true;
      lf.enable = true;
    };

    home = {
      username = "whoselow";
      homeDirectory = "/home/whoselow";
      stateVersion = "24.11";

      packages = with pkgs; [
        prismlauncher
        appimage-run
        wowup-cf
      ];

      file = {
      };

      sessionVariables = {
        NH_FLAKE = "/home/whoselow/.config/nixos";
      };
    };

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
  };
}
