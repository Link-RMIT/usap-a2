require 'spec_helper'
describe 'usap_a2' do

  context 'with defaults for all parameters' do
    it { should contain_class('usap_a2') }
  end
end
