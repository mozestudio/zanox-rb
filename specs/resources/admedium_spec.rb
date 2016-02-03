require_relative '../spec_helper'

describe Zanox::AdMedium do
  before :each do
    Zanox::API::Session.connect_id = '43EEF0445509C7205827'
  end

  describe '#find' do
    let(:admedia) { Zanox::AdMedium.find }

    it 'finds all admedia' do
      expect(admedia.length).to be > 0
    end

    it 'returns a collection of AdMedia' do
      expect(admedia.last).to be_a(Zanox::AdMedium)
    end
  end
end
