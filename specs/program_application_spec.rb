describe Zanox::API do
  describe '#request' do
    context 'program applications' do
      let(:program_applications) { Zanox::API.request('programapplications') }

      it 'returns pagination infos' do
        expect(program_applications.page).to  be   0
        expect(program_applications.items).to be > 0
        expect(program_applications.total).to be > 0
      end

      it 'returns the list of your program applications' do
        program_application = program_applications.program_application_items
        expect(program_application).to be_an(Array)
      end
    end
  end
end
