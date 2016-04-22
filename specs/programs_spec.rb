require_relative 'spec_helper'

describe Zanox::API do
  describe '#request', :vcr do
    context 'programs' do
      let(:programs) { Zanox::API.request('programs') }

      it 'returns pagination infos' do
        expect(programs.page).to  be   0
        expect(programs.items).to be   9
        expect(programs.total).to be > 500
      end

      it 'returns a list of programs' do
        items = programs.program_items
        expect(items).to be_an(Array)
        expect(items).to have_exactly(9).programs
      end
    end
  end
end
