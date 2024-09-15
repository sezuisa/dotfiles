{
  services.davfs2 = {
    enable = true;
  };
  age.secrets.nextcloud = {
    file = ../secrets/davfs2-secrets.age;
    owner = "root";
    group = "root";
    path = "/etc/davfs2/secrets";
    mode = "600";
  };
  fileSystems."/mnt/nextcloud" = {
    fsType = "davfs";
    device = "https://cloud.sezuisa.me/remote.php/webdav/";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=600" # disconnects after 10 minutes (i.e. 600 seconds)
      "rw"
      "user"
      "uid=1000"
      "gid=100"
      "file_mode=0664"
      "dir_mode=2775"
      "grpid"
    ];
  };
}
