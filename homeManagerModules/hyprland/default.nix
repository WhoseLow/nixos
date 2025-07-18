{
  lib,
  pkgs,
  config,
  ...
}: {
  imports = [
    ./monitors.nix
    ./keybinds.nix
  ];
  options.modules.hyprland = {
    enable = lib.mkEnableOption "Enable hyprland";
    hyprsplit.enable = lib.mkEnableOption "Split workspaces plugin";
  };
  config = lib.mkIf config.modules.hyprland.enable {
    modules.waybar.enable = lib.mkDefault true;
    modules.hyprland.hyprsplit.enable = lib.mkDefault true;

    services.hyprpolkitagent.enable = true;
    wayland.windowManager.hyprland = {
      enable = true;
      systemd.enable = false;

      plugins = [pkgs.hyprlandPlugins.hyprsplit];
      # ++ lib.optional
      # config.modules.hyprland.hyprsplit.enable
      # [pkgs.hyprlandPlugins.hyprsplit];

      settings = {
        exec-once = [
          # TODO: create an autostart option which is referenced here
          "waybar"
          "nm-applet"
          "dunst"
          "easyeffects --gapplication-service"
        ];

        general = {
          gaps_in = 3;
          gaps_out = 10;

          border_size = 2;

          resize_on_border = false;

          allow_tearing = false;

          layout = "dwindle";
        };
        decoration = {
          rounding = 10;
          rounding_power = 2;

          active_opacity = 1.0;
          inactive_opacity = 1.0;

          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            #color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;

          bezier = [
            "overshot, 0.05, 0.9, 0.1, 1.05"
            "smoothOut, 0.36, 0, 0.66, -0.56"
            "smoothIn, 0.25, 1, 0.5, 1"
          ];

          animation = [
            "windows, 1, 5, overshot, slide"
            "windowsOut, 1, 4, smoothOut, slide"
            "windowsMove, 1, 4, default"
            "border, 1, 10, default"
            "fade, 1, 10, default"
            "fadeDim, 1, 10, smoothIn"
            "workspaces, 1, 6, default"
          ];
        };
        dwindle = {
          pseudotile = true;
          preserve_split = true;
        };
        master = {
          new_status = "master";
        };
        input = {
          kb_layout = "us";

          follow_mouse = 0;

          sensitivity = 0; # -1.0 to 1.0

          touchpad = {
            natural_scroll = false;
          };
        };
        gestures = {
          workspace_swipe = false;
        };

        windowrule = [
          "suppressevent maximize, class:.*"
          "nofocus,class:^$,title:^$xwayland:1,floating:1,fullscreen:0,pinned:0"
        ];

        binds = {
          workspace_back_and_forth = 1;
        };

        cursor = {
          no_hardware_cursors = true;
        };
      };
    };

    home.packages = with pkgs; [
      grimblast
      wl-clipboard
      dunst
      swww
      networkmanagerapplet
      wofi
      waybar
      hyprlandPlugins.hyprsplit
    ];
    #++ lib.optional
    #config.modules.hyprland.hyprsplit.enable [
    #  pkgs.hyprlandPlugins.hyprsplit
    #];
  };
}
