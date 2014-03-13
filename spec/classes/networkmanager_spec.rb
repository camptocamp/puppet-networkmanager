require 'spec_helper'

describe 'networkmanager' do

  context 'without parameters' do
    it { should compile.with_all_deps }
  end

end

