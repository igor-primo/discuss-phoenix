{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "elixir";
  version = "1.5.0";

  src = pkgs.fetchFromGitHub {
    owner = "elixir-lang";
    repo = "elixir";
    rev = "v${version}";
    sha256 = "1z3wbg49sqik4mfbnmgw3jfy5b9jnn07vjxz8yjfdd8hy9sykfw5";
  };

  buildInputs = [
    pkgs.erlangR19
    pkgs.makeWrapper
  ];

  nativeBuildInputs = [ pkgs.rebar ];

  buildPhase = ''
    make
  '';

  installPhase = ''
    mkdir -p $out/bin $out/lib/elixir
    cp -r bin/* $out/bin/
    cp -r lib/* $out/lib/elixir/
  '';

  meta = with pkgs.lib; {
    description = "Elixir programming language";
    homepage = "https://elixir-lang.org/";
    platforms = platforms.unix;
    maintainers = with maintainers; [ your-name ];
  };
}
