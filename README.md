# Java development environment

Nix flake template for Java and JVM projects. The dev shell provides GraalVM CE as the JDK, Maven, and Gradle. Maven and Gradle are configured to use the GraalVM JDK. The flake is built with [purr](https://flakehub.com/f/nixcafe/purr) and uses [git-hooks.nix](https://flakehub.com/f/cachix/git-hooks.nix) for pre-commit hooks.

Part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection.

## Quick start

Create the project files in the current directory:

```bash
nix flake init -t "github:nixcafe/develop-templates#java" --refresh
```

Register the collection once to use the shorter name:

```bash
nix registry add beans "github:nixcafe/develop-templates"
nix flake init -t beans#java
```

With [cattery-modules](https://github.com/nixcafe/cattery-modules), `beans` is already registered.

You can also create a repository from the template repository:

```bash
gh repo create my-java-project --template nixcafe-develop/java --clone
```

Enter the dev shell:

```bash
nix develop
```

If direnv is installed, `direnv allow` loads the shell when you enter the directory. The template includes an `.envrc` that calls `use flake`.

The template does not include a `flake.lock`. The first `nix develop` resolves the inputs and writes one.

## What's included

| Tool | Purpose |
|------|---------|
| GraalVM CE | JDK used by Maven and Gradle |
| Maven | Build and dependency management |
| Gradle | Build and dependency management |

The dev shell has a shell hook that installs the hooks enabled in `develop/checks/git-hooks/default.nix`. The `hooks` set in this template is empty, so no hooks run until you enable some.

## Useful commands

```bash
nix develop          # enter the dev shell
direnv allow         # load the shell through direnv
mvn --version        # print the Maven and Java versions
gradle --version     # print the Gradle and JVM versions
```

## Customizing

### Use a different JDK

`develop/shells/default/default.nix` sets:

```nix
jdk = pkgs.graalvmPackages.graalvm-ce;
```

Replace it with another JDK package from nixpkgs, for example:

```nix
jdk = pkgs.jdk23;
```

Maven and Gradle are defined in terms of `jdk`, so both use the new JDK.

### Enable pre-commit hooks

`develop/checks/git-hooks/default.nix` starts with an empty `hooks` set. Add entries to enable hooks:

```nix
hooks = {
  nixfmt.enable = true;
  deadnix.enable = true;
  statix.enable = true;
};
```

See [git-hooks.nix](https://github.com/cachix/git-hooks.nix) for the available hooks. The shell hook installs enabled hooks when you enter the dev shell.

## Project structure

```
.
├── flake.nix                          # Flake entry point
├── .envrc                             # direnv: use flake
├── .gitignore
└── develop/
    ├── shells/default/default.nix     # Dev shell (GraalVM, Maven, Gradle)
    └── checks/git-hooks/default.nix   # Pre-commit hook configuration
```
