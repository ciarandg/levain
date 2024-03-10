# Levain

**Note: Currently, this project is pretty much just a proof of concept**

This repo contains helpers for provisioning infrastructure using
Terraform and Nix. Currently, this is split between Terraform modules
and NixOS modules, each of which need to be included independently in a
project. Levain is intended to prioritize convention over configuration,
so that it can be quickly used to bootstrap a project, without
significant overhead.

## Supported Cloud Providers

Currently, Levain only supports Linode. There is some preliminary work
already done to support DigitalOcean, but this is hampered by the need
for dynamically generated networking configuration (see
`nix/hardware/digitalocean/default.nix`). Next up: `fly.io`, Hetzner,
Vultr, and Scaleway.

## Documentation

Currently, the `examples` directory in this repo, and the READMEs inside
of it, are the source of truth on how to use Levain.
