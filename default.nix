{ system ? builtins.currentSystem
, pkgs ? import ./nix/pinned.nix { inherit system; }
}:

pkgs.dockerTools.buildImage {
  name = "kafka-with-nodejs";
  tag = "latest";

  contents = pkgs.buildEnv {
    name = "kafka-with-nodejs-env";
    paths = with pkgs; [
      apacheKafka
      nodejs_22
      bash
      coreutils
      curl
    ];
    pathsToLink = [ "/" ];
  };

  config = {
    Env = [ "PATH=/bin" ];
    WorkingDir = "/app";
    Cmd = [ "${pkgs.bash}/bin/bash" ];
  };
}
