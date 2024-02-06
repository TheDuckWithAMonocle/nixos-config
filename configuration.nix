{ config, libs, pkgs, ... }:
{


  imports =
    [ <home-manager/nixos>
      ./hardware-configuration.nix

        ];
    nix.settings.experimental-features = [ "nix-command""flakes" ];
    hardware= { #GPU
      nvidia = {
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        open = false; # Opensource version
        nvidiaSettings = true;
        package = config.boot.kernelPackages.nvidiaPackages.stable;
        prime = {
          intelBusId = "PCI:0:2:0";
          nvidiaBusId = "PCI:1:0:0";
          };
        };
      opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        };
      bluetooth = {
        enable = true;
        powerOnBoot = true;
      };
    };

  boot = { #Bootloader
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      };
    kernelParams = [];
  };
  networking = {  #Networking
    hostName = "nixos";
    networkmanager.enable = true;
    };

  time.timeZone = "Asia/Kolkata";

  i18n = { #Language
    defaultLocale = "en_IN";
    extraLocaleSettings = {
      LC_ADDRESS = "en_IN";
      LC_IDENTIFICATION = "en_IN";
      LC_MEASUREMENT = "en_IN";
      LC_MONETARY = "en_IN";
      LC_NAME = "en_IN";
      LC_NUMERIC = "en_IN";
      LC_PAPER = "en_IN";
      LC_TELEPHONE = "en_IN";
      LC_TIME = "en_IN";
    };
      };

  services = {
   xserver = { #X11
    enable = true;
    videoDrivers = ["nvidia"];
    displayManager.defaultSession = "plasmawayland";
    displayManager.autoLogin.enable = false;
    displayManager.sddm.enable = true;
    displayManager.sddm.wayland.enable = true;
    desktopManager.plasma5.enable = true;
    layout = "us";
    xkbVariant = "";
    };
    printing = {
      enable = true;
      drivers = [pkgs.epson-escpr];
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
    pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
    };
      };
  fonts = {
    fontDir.enable = true;
    fontconfig.enable = true;
    enableGhostscriptFonts = true;
  };
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  hardware.sane.enable = true;
  hardware.sane.extraBackends = [ pkgs.sane-airscan ];
  security.rtkit.enable = true;


  programs= {
    dconf.enable = true;
    zsh.enable = true;
    };
  users.users.mono = {
   shell = pkgs.zsh;
   isNormalUser = true;
   description = "mono";
   extraGroups = ["networkmanager" "wheel" "libvirtd" "scanner" "lp"];
   packages = with pkgs; [];
   };

  home-manager = {
   useGlobalPkgs = true;
   useUserPackages = true;
   users.mono = import ./home.nix;
   };

  nixpkgs.config = {
  # Allow proprietary packages
  allowUnfree = true;

  # Create an alias for the unstable channel
  packageOverrides = pkgs: {
    unstable = import <nixos-unstable> { # pass the nixpkgs config to the unstable alias # to ensure `allowUnfree = true;` is propagated:
      config = config.nixpkgs.config;
    };
  };
};
  environment.systemPackages = with pkgs; [];
  environment.plasma5.excludePackages = with pkgs.libsForQt5; [
  plasma-browser-integration
  elisa
];
virtualisation = {
  waydroid.enable = true;
  libvirtd.enable = true;

};

  system.stateVersion = "23.11";
}
