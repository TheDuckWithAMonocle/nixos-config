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
 ollama
 kate
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
      jnoortheen.nix-ide
      eamodio.gitlens
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

