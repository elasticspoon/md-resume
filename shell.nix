with import <nixpkgs> { }; let
  env = bundlerEnv {
    ruby = pkgs.ruby;
    name = "md_resume-bundler-env";
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
stdenv.mkDerivation {
  name = "md_resume";
  buildInputs = [ env ];
}
