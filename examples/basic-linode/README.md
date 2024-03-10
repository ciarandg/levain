# Example Stack: basic-linode

This example bootstraps a NixOS install running an unconfigured Nginx
server.

## Setup Steps

1. `git clone git@github.com:ciarandg/levain.git`
2. `cd levain/examples/basic-linode`
4. `ssh-keygen -t ed25519 -P "" -f ./example_ed25519`
   - Generates a keypair using `ed25519` encryption (this is also
       currently the default) with no passphrase
5. Paste the contents of `example_ed25519.pub` in the
   `config.levain.user.authorizedKeys` list in `nixos-config.nix`
3. `cp terraform.tfvars.example terraform.tfvars`
6. Generate a Linode API token, then replace the example value in
   `terraform.tfvars` with it
   - Minimum token permissions:
     - `Events` read-only
     - `Linodes` read-write
   - https://cloud.linode.com/profile/tokens or use the CLI
7. `terraform init`
8. `terraform apply`

That's it! Connect to your newly provisioned machine:
```
IP_ADDRESS=$(terraform output -raw ip_address)
ssh -i example_ed25519 nixos@$IP_ADDRESS
```
## Potential Next Steps

- Add a Terraform provider for a secrets vault or password manager to
    manage SSH keys and API tokens

## Ways This Example Could Be Improved

- Fix duplication of public key contents
- A nix flake template
