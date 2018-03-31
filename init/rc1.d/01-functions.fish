#!/usr/bin/env fish

function nix -d "root command for FishDots Nixos"
  if test 0 -eq (count $argv)
    nix_help
    return
  end
  switch $argv[1]
    case fix
      nix_fix $argv[2]
    case repkg
      nix_repkg $argv[2]
    case clean
      nix_clean
    case install
      nix_install
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
echo -e "nix usage:\n\n\n"
echo -e "nix fix\n\tverify and repair store contents\n"
echo -e "nix repkg\n\tbuild a package\n"
echo -e "nix clean\n\trun nixos garbage collector\n"
echo -e "nix search\n\tfind a package\n"
echo -e "nix upgrade\n\tapply the updated nixos configuration and switch upgrading in the process\n"
echo -e "nix update\n\tapply the updated nixos configuration and switch\n"
echo -e "nix install\n\tinstall a package\n"

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

function nix_install -a pkg -d "install script"
  nix-env -i $pkg
end