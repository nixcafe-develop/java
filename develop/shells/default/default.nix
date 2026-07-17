{
  inputs,
  pkgs,
  system,
  ...
}:
let
  jdk = pkgs.graalvmPackages.graalvm-ce;
  maven = pkgs.maven.override { jdk_headless = jdk; };
  gradle = pkgs.gradle.override { java = jdk; };
in
pkgs.mkShell {
  packages = [
    jdk
    maven
    gradle
  ];

  shellHook = ''
    ${inputs.self.checks.${system}.git-hooks.shellHook}
  '';
  buildInputs = inputs.self.checks.${system}.git-hooks.enabledPackages;
}
