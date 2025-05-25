{
  pkgs,
  lib,
  config,
  ...
}: {
  options.bundles.gaming = {
    enable = lib.mkEnableOption "Gaming related options and applications";
  };
  config = lib.mkIf config.bundles.gaming.enable {
    nixpkgs.config.allowUnfree = true;

    modules = {
    };

    programs.mangohud.enable = true;

    home.packages = with pkgs; [
      (pkgs.lutris.override {
        extraPkgs = pkgs: [
          wineWowPackages.stagingFull
          wineWowPackages.waylandFull
          winetricks
        ];
      })
      steam
      steam-run
      protonup-ng
      gamemode
      dxvk
      gamescope
      mangohud
      r2modman
      heroic
      steamtinkerlaunch
    ];
    home.sessionVariables = {
      STEAM_EXTRA_COMPAT_TOOLS_PATHS = "\${HOME}/.steam/root/compatibilitytools.d";
    };
  };
}
