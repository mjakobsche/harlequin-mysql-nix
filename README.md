## Harlequin Mysql Nix
**Harlequin with mysql support for NixOS**

### Why
Because the current nixpkgs do not include mysql adapter for harlequin.
This flake includes a custom implementation of missing dependencies

### Simple usage
To install: `nix profile install github:mjakobsche/harlequin-mysql-nix`

To update: `nix profile upgrade harlequin-mysql-nix --refresh`

### Disclaimer
The harlequin.nix file is based on the nixpkgs implementation.
