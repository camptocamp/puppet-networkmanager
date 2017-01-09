require 'spec_helper'

describe 'networkmanager' do
  on_supported_os.each do |os, os_facts|
    context 'without parameters' do
      it { should compile.with_all_deps }
    end
  end
end

