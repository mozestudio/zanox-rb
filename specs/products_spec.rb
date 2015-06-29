describe Zanox::API do
  describe '#request' do
    context 'products' do
      let(:products) { Zanox::API.request('products', q: 'nike', programs: 7408) }

      before :each do
        Zanox::API::Session.connect_id = '43EEF0445509C7205827'
      end

      it 'returns pagination infos' do
        expect(products.page).to  be   0
        expect(products.items).to be   10
        expect(products.total).to be > 100
        expect(products.query).to eq('nike')
      end

      it 'returns a list of products with given keyword and program' do
        items = products.product_items

        expect(items).to be_an(Array)
        expect(items).to have_exactly(10).products

        expect(items.all? { |i| i['name'] =~ /nike/i }).to be_truthy
        expect(items.all? { |i| i['program']['@id'].to_i == 7408 }).to be_truthy
      end
    end
  end
end
