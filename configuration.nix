{ config, pkgs, lib, ... }: {
  imports = [ ./hardware-configuration.nix ];

  # Boot loader configuration for Legacy BIOS with GRUB
  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/sda";
  boot.loader.grub.useOSProber = false;

  # Disable systemd-boot and EFI settings
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = false;

  # Networking
  networking.hostName = "nixos-vm";
  networking.networkmanager.enable = true;

  # Enable and configure zsh globally
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    ohMyZsh = {
      enable = true;
      plugins = [ "git" ];
    };
    promptInit = ''
      # Load powerlevel10k theme
      source ${pkgs.zsh-powerlevel10k}/share/zsh-powerlevel10k/powerlevel10k.zsh-theme

      # Load user's zshrc if it exists
      if [[ -f /home/atris/dotfiles/zshrc ]]; then
        source /home/atris/dotfiles/zshrc
      fi

      # Load p10k config if it exists
      if [[ -f /home/atris/.p10k.zsh ]]; then
        source /home/atris/.p10k.zsh
      fi
    '';
    shellInit = ''
      # Set environment variables
      export LD_LIBRARY_PATH="/run/current-system/sw/share/nix-ld/lib:/run/opengl-driver/lib:$LD_LIBRARY_PATH"
      export HF_HOME="/home/atris/.cache/huggingface"
    '';
  };

  # Enable fzf globally
  programs.fzf = {
    fuzzyCompletion = true;
    keybindings = true;
  };

  # Configure git globally
  programs.git = {
    enable = true;
    lfs.enable = true;
  };

  # Configure neovim globally
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    configure = {
      packages.myVimPackage = with pkgs.vimPlugins; { start = [ vim-plug ]; };
      customRC = ''
        " Load user's init.lua if it exists
        if filereadable('/home/atris/dotfiles/nvim/init.lua')
          luafile /home/atris/dotfiles/nvim/init.lua
        endif
      '';
    };
  };

  # Enable NVIDIA drivers and CUDA
  hardware.graphics = { enable = true; };
  hardware.nvidia = {
    modesetting.enable = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    powerManagement.enable = true;
    open = true;
  };
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config = {
    cudaSupport = true;
    allowUnfree = true;
  };

  programs.nix-ld = {
    enable = true; # installs /lib64/ld-linux-x86-64.so.2 shim
    libraries = with pkgs; [
      stdenv.cc.cc.lib # libstdc++.so.6  +  libgcc_s.so.1
      zlib # often needed by wheels
      # add more libs if some wheel complains;
      # you don't need full cudatoolkit – the driver already exports libcuda.so.*
    ];
  };

  nix = {
    # …other nix options…

    settings = {
      trusted-users = [ "root" "atris" ];

      substituters = [ "https://nix-community.cachix.org" ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];

      experimental-features = [
        "nix-command" # unified CLI (`nix build`, `nix run`, etc.)
        "flakes" # flake ecosystem
        # optionally:
        # "repl-flake"   # `:lf` command in `nix repl`
      ];
    };
  };

  # Install all necessary packages system-wide
  environment.systemPackages = with pkgs; [
    # Deep learning and vLLM packages
    cudatoolkit
    pkgs.uv
    (llama-cpp.override { cudaSupport = true; })
    linuxPackages.nvidia_x11
    python3
    python3Packages.pip
    python3Packages.virtualenv
    (python311.withPackages (ps: with ps; [ torch-bin torchaudio-bin ]))

    # Development tools
    git
    git-lfs
    gcc
    gnumake
    cmake
    nixfmt-classic

    # Shell and terminal tools
    zsh
    oh-my-zsh
    zsh-powerlevel10k
    fzf
    bat
    mcfly
    zellij

    # System monitoring and utilities
    nvtopPackages.nvidia
    zenith

    # Media tools
    yt-dlp
    ffmpeg

    # Development environments
    bun
    neovim
  ];

  # Enable SSH for remote access
  services.openssh.enable = true;

  # Configure sudo to not require password for atris user
  security.sudo = {
    enable = true;
    wheelNeedsPassword = false;
  };

  # Set up a user
  users.users.atris = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "wheel" "networkmanager" ];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDM7ZAHFoAIZ3EWW1//+eAmQXBk567OUMQbkvoUfQLpupHDAadUT1uW1LDmTyHhy930VxaVmLscU9boMXaikyLzhOKkb3+GH3BuakZ4/We3quBL5XK8YQQ6usfBis6Pv0OiCmUFS97uHNjXj7xMJ4wfguvnLwUyTCzl6bsa7NChu5wdgpM4W+Q9iSKF0onsOZTLTF5bz7rPJteAR027o+ATyXkq6u9w0uLCgahkJV2pO/Tpm85aQxKnlDJ9bk4p/S2YcC1mMPK9V7fbG5Pz90sxs8fN6WJTq3kWrdP7JEZH9jT7J0cgmqDMeCaDOC0Lp3+UyHpZDJXcGAJxqeB8YWv6Cmf3dVo+q8SyNHZOSXpWHGbQO9L5sRvBMm8wzxC6xps20Ho3WnBiXiNdvu7T8W4yUCZGgzcpAoneOhFqZUoUplw+aOhmTneWIBlCs5gsn/lzETRGHVJIcw16892j0nHyK2mmbj7wTYpTVt2mq4sxCGCfddae5FfD7KY7jyyrnO5+m/KfPbZb9dlhR6RNudf1ffs7VzrzYKegDoAc3hxVgo4YYVLczncRACrnCJcXpqN2T3IDsOmWzozKV8ZjYF/8tTAPIu9y3YuGmqnsDi14Jnhm2UHp1I5N1AFs9leHyQtJLgVhqWeTLbnEDSDZynxjiJ5DxDIOuGLQcfcKeHkP5w=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOrfcBLNeJzl9r3H+VzHgpY+Ml5dSrDg26BqyJwYkz3Z"
    ];
  };

  # Create symlinks for dotfiles using systemd tmpfiles
  systemd.tmpfiles.rules = [
    "L+ /home/atris/.p10k.zsh - - - - /home/atris/dotfiles/p10k.zsh"
    "L+ /home/atris/.config/nvim - - - - /home/atris/dotfiles/nvim"
  ];

  # Firewall settings
  networking.firewall.enable = true;
  networking.firewall.allowedTCPPorts = [ 22 8000 8080 11434 ];

  # System version
  system.stateVersion = "24.11";

  virtualisation.docker.enable = true;

  # makes `/dev/nvidia*` available inside containers
  hardware.nvidia-container-toolkit.enable = true;
}
