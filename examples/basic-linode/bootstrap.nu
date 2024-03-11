#!/usr/bin/env nu

# - Generates an SSH key named `example_ed25519`
# - Creates a Linode API key with the minimum valid permissions
# - Runs `tofu init`
# - Prints remaining manual tasks

def generate_token [] {
  let expiry_date = (^date -I -d $"(^date "+%Y-%m-%d") +1 month")
  let expiry_time = $"($expiry_date)T00:00:00"
  let permissions = "events:read_only,linodes:read_write"
  (linode-cli profile token-create
      --label "levain-example-basic-linode"
      --scopes $permissions
      --expiry $expiry_time
      --json
    | from json | get 0 | get token)
}

let tofu_exists = (which tofu | length | $in > 0)
if not $tofu_exists {
  print "Error: OpenTofu is not installed"
  exit 1
}

ssh-keygen -t ed25519 -P "" -f ./example_ed25519
let linode_token = (generate_token)
open terraform.tfvars.tpl | str replace "{{linode_token}}" $linode_token | save -f terraform.tfvars
tofu init

print "\nBootstrap complete! Please paste the following value into `nixos-config.nix`:\n"
print (open example_ed25519.pub)
