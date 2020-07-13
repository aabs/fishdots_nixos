#!/usr/bin/env fish

define_command fdnix "fishdots plugin for doing useful things with nixos"

define_subcommand_nonevented fdnix fix nix_fix "verify and repair store contents"
define_subcommand_nonevented fdnix repkg nix_repkg "build a package"
define_subcommand_nonevented fdnix clean nix_clean "run nixos garbage collection"
define_subcommand_nonevented fdnix search nix_search "find a package"
define_subcommand_nonevented fdnix upgrade nix_upgrade "apply the updated nixos configuration and switch upgrading in the process"
define_subcommand_nonevented fdnix update nix_update "apply the update configuration and switch"
define_subcommand_nonevented fdnix install nix_install "install a package"
define_subcommand_nonevented fdnix ls nix_ls "list installed packages"
define_subcommand_nonevented fdnix rm nix_rm "<pkg> remove package"

function nixpaste -d ""
  curl -F "text=<-" http://nixpaste.lbr.uno
end

function nix_fix -d ""
  sudo nix-store --verify --check-contents --repair
end

function nix_repkg -d ""
  sudo nix-build --check -A
end

function nix_clean -d ""
  sudo nix-collect-garbage -d
end

function nix_search -a pattern -d "description"
  nix-env -qaP --description \* | sed -re "s/^nixos\.//g" | fgrep -i $pattern
end

function nix_update -d ""
  sudo nixos-rebuild switch
end

function nix_upgrade -d ""
  sudo nixos-rebuild switch --upgrade
end

function nix_install -a pkg -d "install script"
  nix-env -i $pkg
end

function nix_ls -d "display a list oif what's installed"
  nix-env -q
end

function nix_rm -a pkg -d "remove package"
  nix-env -e pkg
end
