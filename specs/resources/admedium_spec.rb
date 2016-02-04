require_relative '../spec_helper'

describe Zanox::AdMedium do
  before :each do
    Zanox::API::Session.connect_id = '43EEF0445509C7205827'
  end

  describe '#find' do
    let(:admedia) { Zanox::AdMedium.find }

    it { expect(admedia).to be_a(Array) }
    it { expect(admedia).to_not be_empty }
    it { expect(admedia.last).to be_a(Zanox::AdMedium) }
  end
end
