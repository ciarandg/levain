{config, lib, ...}: let
  cfg = config.levain.user;
in {
  options = {
    levain.user.authorizedKeys = lib.mkOption {
      description = "A list of SSH public keys to connect to this instance with";
      type = lib.types.listOf lib.types.str;
    };
  };
  config = {
    users = {
      mutableUsers = false;
      users.nixos = {
        hashedPasswordFile = "/nixos_hashed_password";
        extraGroups = ["wheel" "sudo"];
        isNormalUser = true;
        openssh.authorizedKeys.keys = cfg.authorizedKeys;
      };
    };
  };
}
