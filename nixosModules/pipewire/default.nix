{
  config,
  lib,
  pkgs,
  ...
}:
with lib; {
  options = {
    modules.pipewire.enable = mkEnableOption "Enable pipewire";
  };

  config = mkIf config.modules.pipewire.enable {
    environment.systemPackages = with pkgs; [
      wireplumber
    ];
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
    };
  };
}
