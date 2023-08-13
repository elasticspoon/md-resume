with import <nixpkgs> { }; let
  env =
    bundlerEnv
      {
        ruby = pkgs.ruby;
        name = "markdown-resume-bundler-env";
        gemfile = ./Gemfile;
        lockfile = ./Gemfile.lock;
        gemset = ./gemset.nix;
      };
in
stdenv.mkDerivation {
  name = "markdown-resume";
  buildInputs = with pkgs; [ ruby chromium ] ++ [ env ];

  shellHook = ''
    PATH="${env}/bin:$PATH"
    alias dev_start='foreman start'
  '';
}
