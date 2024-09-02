{ pkgs ? import <nixpkgs> {} }:

pkgs.stdenv.mkDerivation rec {
  pname = "erlang";
  version = "19.0";

  src = pkgs.fetchFromGitHub {
    owner = "erlang";
    repo = "otp";
    rev = "OTP-${version}";
    sha256 = "sha256-5VrYGYrERsWWy8rAi64HrcVJk9WfTuCSkIXgS7CC8SE=";
  };

  nativeBuildInputs = [ pkgs.autoconf pkgs.libxslt pkgs.libxml2 pkgs.openssl pkgs.zlib ];

  buildInputs = [ pkgs.ncurses ];

  configureFlags = [
    "--enable-smp-support"
    "--enable-threads"
    "--enable-kernel-poll"
    "--enable-dynamic-ssl-lib"
    "--with-ssl=$(pkg-config --variable=libdir openssl)"
    "--enable-hipe"
  ];

  buildPhase = ''
    ./otp_build autoconf
    ./configure --prefix=$out 
  '';

  installPhase = ''
    make
    make install
  '';

  meta = with pkgs.lib; {
    description = "Erlang/OTP 19.0";
    homepage = "https://www.erlang.org/";
    platforms = platforms.unix;
    maintainers = with maintainers; [ your-name ];
  };
}
