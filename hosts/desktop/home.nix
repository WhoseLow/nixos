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

    modules.hyprland = {
      monitors = [
        "DP-4, highrr, 0x0, 1"
        "DP-6, highrr, auto, 1, transform, 1"
      ];
      # hyprsplit.enable = false;
    };

    bundles = {
      cli_utils.enable = true;
      desktop.enable = true;
      gaming.enable = true;
    };

    modules = {
      hyprland = {
        enable = true;
        # hdr.enable = true;
      };
      obs-studio.enable = true;
      lf.enable = true;
      vscode.enable = true;
      obsidian.enable = true;
      discord.enable = true;
    };

    # TODO: move this
    stylix = {
      targets = {
        vesktop.enable = false;
      };
      iconTheme = {
        enable = true;
        package = pkgs.candy-icons;
        dark = "candy-icons";
        light = "candy-icons";
      };
    };

    home = {
      username = "whoselow";
      homeDirectory = "/home/whoselow";
      stateVersion = "24.11";

      packages = with pkgs; [
        prismlauncher
        appimage-run
        wowup-cf
        popcorntime
        # TODO: move these to bundle
        tidal-hifi
        gimp
        openvpn
        vopono
        r2modman
        jellyfin-media-player
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
