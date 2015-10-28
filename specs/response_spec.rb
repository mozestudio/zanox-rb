require_relative 'spec_helper'

describe Zanox::API do
  describe '#method_missing' do
    context '*_items always returns an array' do
      let(:response) { Zanox::API.request('programs') }

      context 'has items' do
        it 'returns one or more items' do
          items = response.program_items
          expect(items).to be_an(Array)
          expect(items).to have_at_least(1).item
        end
      end

      context 'has no items' do
        it 'returns an empty array' do
          items = response.tasukete_items
          expect(items).to be_an(Array)
          expect(items).to have_exactly(0).items
        end
      end
    end
  end
end
