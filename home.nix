{config, pkgs, inputs, ...}:
{
 home.username = "mono";
 home.homeDirectory = "/home/mono";
 home.stateVersion = "23.11";
 home.packages =  with pkgs; [
 firefox
 vscode
 keepassxc
 anki-bin
 vesktop
 lshw
 pciutils
 git
 lutris
 libreoffice-qt
 nix-update
 qbittorrent
 gnome3.adwaita-icon-theme
 wineWowPackages.waylandFull
 akregator
 epson-escpr
 obs-studio
 strawberry
 picard
 virt-manager
 obsidian
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
      mhutchie.git-graph
      jnoortheen.nix-ide
      github.vscode-pull-request-github
    ];
  };
  zsh = {
    enable = true;
    initExtra = ''source ${pkgs.grml-zsh-config}/etc/zsh/zshrc'';
    shellAliases = {
       update = "sudo nixos-rebuild switch";
    };

  };
  firefox = {
    enable = true;


};
  };

}

