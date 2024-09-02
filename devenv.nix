{ pkgs, lib, config, inputs, ... }:

{
  packages = [ 
    pkgs.git
  ];

  enterShell = ''
    export PATH="$HOME/.mix/escripts:$PATH"
  '';

  services.postgres.enable = true;

  languages.nix.enable = true;
  languages.elixir.enable = true;
  languages.elixir.package = pkgs.elixir_1_10;

  pre-commit.hooks.mix-format.enable = true;
}
