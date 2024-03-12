{config, pkgs, inputs, ...}:
let

    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {inherit pkgs;};

in
{
 home.username = "mono";
 home.homeDirectory = "/home/mono";
 home.stateVersion = "23.11";
 home.packages =  with pkgs; [
 firefox
 vscode
 keepassxc
 unstable.vesktop
 git
 lutris
 libreoffice-qt
 qbittorrent
 gnome3.adwaita-icon-theme
 wineWowPackages.waylandFull
 epson-escpr
 obs-studio
 virt-manager
 python3
 thunderbird
 skanpage
 krita
 godot_4
 google-fonts
 unstable.hexchat
 nicotine-plus
 audacity
 strawberry
 unstable.foliate
 kate
 obsidian
 nixpkgs-review
 blender-hip
 lazygit

  ];

  dconf.settings = {
  "org/virt-manager/virt-manager/connections" = {
    autoconnect = ["qemu:///system"];
    uris = ["qemu:///system"];
  };
};

 programs = {
  vscode = {
    enable = true;
    mutableExtensionsDir = true;
    extensions = with pkgs.vscode-extensions; [
      yzhang.markdown-all-in-one
      foam.foam-vscode
      jnoortheen.nix-ide
      eamodio.gitlens
    ];
  };
  zsh = {
    enable = true;
    initExtra = ''source ${pkgs.grml-zsh-config}/etc/zsh/zshrc'';
    shellAliases = {
       update = "sudo nixos-rebuild switch";
       clean = "sudo nix-collect-garbage -d";
    };

  };
  firefox = {
    enable = true;
    profiles.default = {
      extensions = with nur.repos.rycee.firefox-addons; [
        ublock-origin
        violentmonkey
        user-agent-string-switcher

      ];
      settings = {
        "browser.newtabpage.activity-stream.showSponsoredTopSites" = false;
        "dom.security.https_only_mode" = true;
        "identity.fxaccounts.enabled" = false;
        "signon.rememberSignons" = false;
        "extensions.pocket.enabled" = false;
      };
    };
   };
 };
}





