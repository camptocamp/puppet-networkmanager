module NetworkManager =
  autoload xfm
  (* Same format as Puppet's IniFile *)
  let lns = Puppet.lns
  let filter = incl "/etc/NetworkManager/system-connections/*"
  let xfm = transform lns filter
