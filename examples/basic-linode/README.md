# Example Stack: basic-linode

This example bootstraps a NixOS install running an unconfigured Nginx
server.

## Setup Steps (Scripted)

1. `git clone git@github.com:ciarandg/levain.git`
2. `cd levain/examples/basic-linode`
3. `./bootstrap.nu`
4. As indicated by the script output, paste the contents of
   `example_ed25519.pub` in the `config.levain.user.authorizedKeys` list
   in `nixos-config.nix`
5. `tofu apply`

That's it! Connect to your newly provisioned machine:
```sh
IP_ADDRESS=$(tofu output -raw ip_address)
ssh -i example_ed25519 nixos@$IP_ADDRESS
```
## Potential Next Steps

- Add a Terraform provider for a secrets vault or password manager to
    manage SSH keys and API tokens

## Ways This Example Could Be Improved

- Fix duplication of public key contents
- A nix flake template
