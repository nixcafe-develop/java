{ inputs, system, ... }:
inputs.git-hooks.lib.${system}.run {
  src = ../../..;
  hooks = { };
}
