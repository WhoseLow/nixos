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
  ];

  config = {
    # Bootloader
    boot.loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
    };

    home-manager.backupFileExtension = "backup";

    networking = {
      hostName = "nixos"; # Define your hostname
      # networking.wireless.enable = true; # Enables wireless support via wpa_supplicant

      # Configure network proxy if necessary
      # proxy.default = "http://user:password@proxy:port/";
      # proxy.noProxy = "127.0.0.1,localhost,internal.domain";

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
    };

    hardware.cpu.amd.updateMicrocode = true;

    programs.steam.enable = true;
    services.zerotierone = {
      enable = true;
      joinNetworks = ["fada62b0156e96f9"];
      port = 9994;
    };

    stylix = {
      enable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/catppuccin-mocha.yaml";
      image = ./../../wallpaper.jpg;
      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.roboto-mono;
          name = "RobotoMono Nerd Font";
        };
      };
    };

    # Define a user account. Don't forget to set a password with ‘passwd’.
    users.users.whoselow = {
      isNormalUser = true;
      description = "WhoseLow";
      extraGroups = ["networkmanager" "wheel"];
      packages = with pkgs; [
        wineWowPackages.stagingFull
        wineWowPackages.waylandFull
        winetricks
      ];
    };

    # Allow unfree packages
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      git
      vim
    ];

    nix.nixPath = ["nixpkgs=${inputs.nixpkgs}"];

    environment.sessionVariables = {
      NH_FLAKE = "/home/whoselow/.config/nixos";
    };

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

    # Open ports in the firewall.
    # networking.firewall.allowedTCPPorts = [ ... ];
    # networking.firewall.allowedUDPPorts = [ ... ];
    # Or disable the firewall altogether.
    # networking.firewall.enable = false;

    # This value determines the NixOS release from which the default
    # settings for stateful data, like file locations and database versions
    # on your system were taken. It‘s perfectly fine and recommended to leave
    # this value at the release version of the first install of this system.
    # Before changing this value read the documentation for this option
    # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
    system.stateVersion = "24.11"; # Did you read the comment?
  };
}
