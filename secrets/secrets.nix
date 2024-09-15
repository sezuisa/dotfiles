let
  irrenhost = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPp1oKqkL6R1TkE5Lnfi3n/m4/9V0iCKL+CaOUINQKY/ root@irrenhost";
  irrenhost-sez = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPk1h1lfFRthXiIA8UtWc5P5UmwZ2JjWiRv748Syx3jL sez@irrenhost";
  all = [ irrenhost irrenhost-sez ];
in
{
  "davfs2-secrets.age".publicKeys = all;
}
