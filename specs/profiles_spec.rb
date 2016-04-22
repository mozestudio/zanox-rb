require_relative 'spec_helper'

describe Zanox::API do
  describe '#request', :vcr do
    context 'profiles' do
      let(:profiles) { Zanox::API.request('profiles').profile_item }

      it 'returns a list of items' do
        expect(profiles).to have_at_least(1).profile
      end

      it 'returns a list of profiles with fields talking about the relative owner' do
        profile = profiles.first

        expect(profile['@id'].to_i).to be > 0

        expect(profile['firstName']).to     be_a(String)
        expect(profile['firstName']).not_to be_empty

        expect(profile['email']).to      be_a(String)
        expect(profile['email']).not_to  be_empty

        expect(profile['userName']).to     be_a(String)
        expect(profile['userName']).not_to be_empty
      end
    end
  end
end
