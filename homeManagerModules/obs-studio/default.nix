{
  config,
  lib,
  pkgs,
  ...
}: {
  options.modules.obs-studio = {
    enable = lib.mkEnableOption "Enables OBS Studio";
  };
  config = lib.mkIf config.modules.obs-studio.enable {
    programs.obs-studio = {
      enable = true;

      # Enables Nvidia Encoding
      package = pkgs.obs-studio.override {
        cudaSupport = true;
      };

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-pipewire-audio-capture
      ];
    };
  };
}
