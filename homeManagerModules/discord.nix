{
  pkgs,
  config,
  lib,
  ...
}: {
  options.modules.discord = {
    enable = lib.mkEnableOption "Discord";
  };
  config = lib.mkIf config.modules.discord.enable {
    programs.vesktop = {
      enable = true;
      settings = {
        arRPC = true;
        hardwareAcceleration = lib.mkDefault true;
        hardwareVideoAcceleration = lib.mkDefault true;
      };
      vencord.settings = {
        transparent = true;
        plugins = {
          VolumeBooster.enabled = true;
        };
      };
    };

    #TODO: add option to enable/disable, along with associated settings
    services.arrpc.enable = true;
  };
}
