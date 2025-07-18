{
  lib,
  config,
  ...
}: {
  config.wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      # TODO: set this up to import based on which programs are enabled
      "$terminal" = "alacritty";
      "$fileManager" = "thunar";
      "$browser" = "zen";
      "$menu" = ''
        uwsm app -- "$(wofi --show drun --define=drun-print_desktop_file=true | sed -E "s/(\.desktop) /\1:/")"
      '';

      bind = let
        toWSNumber = n: (toString (
          if n == 0
          then 10
          else n
        ));

        moveworkspace-command =
          if config.modules.hyprland.hyprsplit.enable
          then "split:movetoworkspace"
          else "movetoworkspace";
        moveworkspaces = map (n: "$mod SHIFT, ${toString n}, ${moveworkspace-command}, ${toWSNumber n}") [1 2 3 4 5 6 7 8 9 0];

        workspace-command =
          if config.modules.hyprland.hyprsplit.enable
          then "split:workspace"
          else "workspace";

        workspaces = map (n: "$mod, ${toString n}, ${workspace-command}, ${toWSNumber n}") [1 2 3 4 5 6 7 8 9 0];
      in
        [
          "$mod, X, exec, $terminal"
          "$mod, Q, killactive"
          "$mod, E, exec, $fileManager"
          "$mod, B, exec, $browser"
          "$mod SHIFT, F, togglefloating"
          "$mod, R, exec, $menu"
          "$mod, G, togglegroup"
          "$mod, bracketleft, changegroupactive, b"
          "$mod, bracketright, changegroupactive, f"
          "$mod, P, pin, active"
          "$mod, F, fullscreen"
          # Screenshot
          "SUPER SHIFT, S, exec, grimblast --notify copysave area"

          "$mod, h, moveFocus, l"
          "$mod, j, moveFocus, d"
          "$mod, k, moveFocus, u"
          "$mod, l, moveFocus, r"

          "$mod SHIFT, h, movewindow, l"
          "$mod SHIFT, j, movewindow, d"
          "$mod SHIFT, k, movewindow, u"
          "$mod SHIFT, l, movewindow, r"
        ]
        ++ workspaces
        ++ moveworkspaces;

      binde = [
        "$mod SHIFT, h, moveactive, -20 0"
        "$mod SHIFT, l, moveactive, 20 0"
        "$mod SHIFT, k, moveactive, 0 -20"
        "$mod SHIFT, j, moveactive, 0 20"

        "$mod CTRL, l, resizeactive, 30 0"
        "$mod CTRL, h, resizeactive, -30 0"
        "$mod CTRL, k, resizeactive, 0 -10"
        "$mod CTRL, j, resizeactive, 0 10"
      ];

      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];
    };
  };
}
