{ config, pkgs, ... }:

# sample NixOS on Raspberry Pi 3

{
  import = [ ./priv.nix ];
  boot.loader.grub.enable = false;
  boot.kernelModules = [ "rt2800usb" ];
  boot.kernelParams = [ "boot.panic_on_fail" ];

  networking = {
    hostName = "the-2020-machine";
    wireless.enable = true;
    wireless.interfaces = [ "wlan0" ];
    enableRalinkFirmware = true;
  };
  hardware.enableAllFirmware = true;
  powerManagement.enable = true;

  environment.systemPackages = with pkgs; [ git stow nix-repl vim ];

  fileSystems = {
    "/" = {
      devices = "UUID=44444444-4444-4444-888888888888";
      fsType = "ext4";
    };
    "/boot" = {
      devices = "UUID=2178-694E";
    };
  };

  services = {
    openssh = {
      enable = true;
      permitRootLogin = "yes";
    };
    avahi = {
      enable = true;
      nssmdns = true;
      publish.addresses = true;
      publish.enable = true;
      publish.workstation = true;
      publish.domain = true;
    };
    xserver.enable = false;
    nixosManual.enable - false;
  };

  nixpkgs.config.allowUnfree = true;
  users.extraUsers = {
    peel = {
      home = "/home/peel";
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      uid = 1000;
    };
  };
}
