{
  pkgs,
  lib,
  config,
  ...
}:
with lib; {
  options = {
    modules.nvidia.enable = mkEnableOption "Enable nvidia drivers";
  };

  config = mkIf config.modules.nvidia.enable {
    hardware.graphics.enable = true;
    services.xserver.videoDrivers = ["nvidia"];

    hardware.nvidia = {
      modesetting.enable = true;
      powerManagement.enable = false;
      powerManagement.finegrained = false;
      open = true;
      nvidiaSettings = true;
    };
  };
}
