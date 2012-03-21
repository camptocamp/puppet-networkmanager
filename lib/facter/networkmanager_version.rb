Facter.add("networkmanager_version") do
  setcode do
    Facter::Util::Resolution.exec('NetworkManager --version').chomp
  end
end
