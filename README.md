# Nix Flake · Java Dev Template

> purr · git-hooks · java · jvm · maven · gradle · graalvm · reproducible · nix-flake

Nix flake template for Java/JVM development — reproducible dev shell with GraalVM JDK, Maven, Gradle, and git pre-commit hooks. Built on [purr](https://flakehub.com/f/nixcafe/purr) and [git-hooks.nix](https://flakehub.com/f/cachix/git-hooks.nix).

Part of the [develop-templates](https://github.com/nixcafe/develop-templates) collection (`nix flake init`-ready).

## Quick Start

### `nix flake init`

```bash
nix flake init -t "github:nixcafe/develop-templates#java" --refresh
```

Register an alias:
```bash
nix registry add beans "github:nixcafe/develop-templates"
nix flake init -t beans#java
```

> **Tip**: With [cattery-modules](https://github.com/nixcafe/cattery-modules), `beans` is pre-registered.

### Create from Template

```bash
gh repo create my-java-project --template nixcafe/java --clone
```

### Enter the Dev Shell

```bash
direnv allow
mvn --version   # or: gradle --version
```

## What's Inside

| Tool | Purpose |
|------|---------|
| `GraalVM CE` | JDK with GraalVM native-image support |
| `maven` | Build & dependency management |
| `gradle` | Build & dependency management |

## Customizing

### Switch JDK

Edit `develop/shells/default/default.nix`:

```nix
jdk = pkgs.jdk23;  # standard OpenJDK
```

### Enable Pre-commit Hooks

Edit `develop/checks/git-hooks/default.nix`:

```nix
hooks = {
  nixfmt.enable = true;
  deadnix.enable = true;
  statix.enable = true;
};
```

See [git-hooks.nix](https://github.com/cachix/git-hooks.nix) for available hooks.

## Project Structure

```
.
├── flake.nix                          # Flake entrypoint
├── .envrc                             # direnv: use flake
├── .gitignore
└── develop/
    ├── shells/default/default.nix     # Dev shell (GraalVM, Maven, Gradle)
    └── checks/git-hooks/default.nix   # Pre-commit hook config
```
