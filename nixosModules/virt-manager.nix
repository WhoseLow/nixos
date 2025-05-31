{
  config,
  lib,
  ...
}: {
  options = {
    modules.virt-manager.enable = lib.mkEnableOption "Enable virt-manager";
  };

  config = lib.mkIf config.modules.virt-manager.enable {
    programs.virt-manager.enable = true;
    users.groups.libvirtd.members = ["whoselow"];
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
  };
}
