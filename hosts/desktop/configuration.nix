{
  config,
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    inputs.home-manager.nixosModules.default
    ./../../nixosModules
    ./../../stylix/cat-mocha.nix
  ];

  config = {
    # Bootloader
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    home-manager.backupFileExtension = "backup";

    networking = {
      hostName = "desktop"; # Define your hostname
      # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      proxy.noProxy = "127.0.0.1,localhost,internal.domain";

      # Open ports in the firewall.
      firewall.allowedTCPPorts = [
        25565
      ];
      # networking.firewall.allowedUDPPorts = [ ... ];
      # Or disable the firewall altogether.
      # networking.firewall.enable = false;

      # Enable networking
      networkmanager.enable = true;
    };

    # Enable flakes
    nix.settings.experimental-features = ["nix-command" "flakes"];

    # Set your timeZone
    time.timeZone = "America/New_York";

    # Select internationalisation properties.
    i18n.defaultLocale = "en_US.UTF-8";

    i18n.extraLocaleSettings = {
      LC_ADDRESS = "en_US.UTF-8";
      LC_IDENTIFICATION = "en_US.UTF-8";
      LC_MEASUREMENT = "en_US.UTF-8";
      LC_MONETARY = "en_US.UTF-8";
      LC_NAME = "en_US.UTF-8";
      LC_NUMERIC = "en_US.UTF-8";
      LC_PAPER = "en_US.UTF-8";
      LC_TELEPHONE = "en_US.UTF-8";
      LC_TIME = "en_US.UTF-8";
    };

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };

    modules = {
      nvidia.enable = true;
      hyprland.enable = true;
      zsh.enable = true;
      pipewire.enable = true;
      virt-manager.enable = true;
      thunar.enable = true;
    };

    programs.steam.enable = true;

    programs.adb.enable = true;

    services = {
      zerotierone.enable = true;
      btrfs.autoScrub = {
        enable = true;
        interval = "weekly";
        fileSystems = ["/"];
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.whoselow = {
      isNormalUser = true;
      description = "WhoseLow";
      extraGroups = ["networkmanager" "wheel" "kvm" "adbusers"];
      packages = with pkgs; [
        wineWowPackages.stagingFull
        wineWowPackages.waylandFull
        winetricks
      ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;
    hardware.enableRedistributableFirmware = true;

    environment.systemPackages = with pkgs; [
      git
      neovim
    ];

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users = {
        "whoselow" = import ./home.nix;
      };
    };

    # Some programs need SUID wrappers, can be configured further or are
    # started in user sessions.
    # programs.mtr.enable = true;
    # programs.gnupg.agent = {
    #   enable = true;
    #   enableSSHSupport = true;
    # };

    # List services that you want to enable:

    # Enable the OpenSSH daemon.
    # services.openssh.enable = true;

    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
