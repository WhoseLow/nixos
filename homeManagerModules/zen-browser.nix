{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [
    inputs.zen-browser.homeModules.beta
  ];
  options.modules.zen-browser = {
    enable = lib.mkEnableOption "Zen Browser";
  };
  config = lib.mkIf config.modules.zen-browser.enable {
    programs.zen-browser = {
      enable = true;
      policies = {
        AutofillAdressEnabled = false;
        AutofillCreditCardEnabled = false;
        DisableAppUpdate = true;
        DisableFeedbackCommands = true;
        DisablePocket = true;
        DisableTelemetry = true;
        DisableSetDesktopBackground = true;
        DontCheckDefaultBrowser = true;
        EnableTrackingProtection = {
          Value = true;
          Locked = true;
          Cryptomining = true;
          Fingerprinting = true;
          EmailTracking = true;
        };
        ExtensionSettings = {
          "uBlock0@raymondhill.net" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/ublock_origin.xpi";
            installation_mode = "force_installed";
          };
          "jid1-BoFifL9Vbdl2zQ@jetpack" = {
            install_url = "https://addons.mozilla.org/firefox/downloads/latest/decentraleyes.xpi";
            installation_mode = "force_installed";
          };
        };
        NoDefaultBookmarks = true;
        OfferToSaveLogins = false;
        PasswordManagerEnabled = false;
      };
    };
  };
}
