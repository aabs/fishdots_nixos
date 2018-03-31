#!/usr/bin/env fish

function nix -d "root command for FishDots Nixos"
  if test 0 -eq (count $argv)
    problem_help
    return
  end
  switch $argv[1]
    case fix
      nix_fix $argv[2]
    case repkg
      nix_repkg $argv[2]
    case clean
      nix_clean
    case update
      nix_update $argv[2]
    case search
      nix_search $argv[2]
    case upgrade
      nix_upgrade $argv[2]
    case update
      nix_update $argv[2]
    case '*'
      nix_help
  end
end

function nix_help -d "usage help"
echo -e "usage:\nblahblah"    
end


function nixpaste -d ""
    curl -F "text=<-" http://nixpaste.lbr.uno
end

function nix_fix -d ""
    nix-store --verify --check-contents --repair
end

function nix_repkg -d ""
    nix-build --check -A
end

function nix_clean -d ""
    nix-collect-garbage -d
end

function nix_search -a pattern -d "description"
    nix-env -qaP --description \* | sed -re "s/^nixos\.//g" | fgrep -i $pattern
end

function nix_update -d ""
    nixos-rebuild switch
end

function nix_upgrade -d ""
    nixos-rebuild switch --upgrade
end

