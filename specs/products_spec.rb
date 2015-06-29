describe Zanox::API do
  describe '#request' do
    before :each do
      Zanox::API::Session.connect_id = '43EEF0445509C7205827'
    end

    context 'products with given keyword and programID' do
      let(:products) { Zanox::API.request('products', q: 'nike', programs: 7408) }

      it 'returns pagination infos' do
        expect(products.page).to  be   0
        expect(products.items).to be   10
        expect(products.total).to be > 100
        expect(products.query).to eq('nike')
      end

      it 'returns a list of products' do
        items = products.product_items

        expect(items).to be_an(Array)
        expect(items).to have_exactly(10).products

        expect(items.all? { |i| i['name'] =~ /nike/i }).to be_truthy
        expect(items.all? { |i| i['program']['@id'].to_i == 7408 }).to be_truthy
      end
    end

    context 'products with given keyword and number of requested items per page' do
      let(:products) { Zanox::API.request('products', q: 'nike', items: 50) }

      it 'returns pagination infos' do
        expect(products.page).to  be   0
        expect(products.items).to be   50
        expect(products.total).to be > 100
        expect(products.query).to eq('nike')
      end
    end

    # context 'products#next_page!' do
    #   let(:products) { Zanox::API.request('products', q: 'iPod', items: 50) }
    #
    #   it 'move the paginator to the second page of the products list' do
    #     expect { products.next_page! }.to change { products.page }.from(0).to(1)
    #   end
    # end

    context 'products#next_page' do
      let(:products) { Zanox::API.request('products', q: 'iPod', items: 50) }

      it 'returns a new response containing the second page of the products list' do
        expect(products.page).to           be 0
        expect(products.next_page.page).to be 1
      end
    end

    context 'products#previous_page' do
      let(:products) { Zanox::API.request('products', q: 'nike', page: 3) }

      it 'returns a new response containing the second page of the products list' do
        expect(products.page).to               be 3
        expect(products.previous_page.page).to be 2
      end
    end
  end
end
