{config, ...}: {
  config = {
    users = {
      mutableUsers = false;
      users.nixos = {
        hashedPasswordFile = "/nixos_hashed_password";
        extraGroups = ["wheel" "sudo"];
        isNormalUser = true;
        openssh.authorizedKeys.keyFiles = ["/nixos_authorized_keys"];
      };
    };
  };
}
