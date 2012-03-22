output = Facter::Util::Resolution.exec('NetworkManager --version')

unless output.nil?
  Facter.add("networkmanager_version") do
    setcode do
      output.chomp
    end
  end
end
