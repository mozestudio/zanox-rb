require_relative '../spec_helper'

describe Zanox::Product do
  before :each do
    Zanox::API::Session.connect_id = '43EEF0445509C7205827'
  end

  describe '#find' do
    let(:iphone) { Zanox::Product.find('iphone') }
    let(:book)   { Zanox::Product.find('book')   }
    let(:nike)   { Zanox::Product.find('nike')   }

    it 'finds products by keyword' do
      expect(iphone.length).to be >= 8
      expect(book.length).to   be >= 8
      expect(nike.length).to   be >= 8
    end

    it 'returns a collection of Products' do
      expect(iphone.last).to be_a(Zanox::Product)
    end
  end

  describe '#from_shop' do
    let(:products) { Zanox::Product.from_shop(5563) }

    it 'finds products by keyword' do
      expect(products.length).to be >= 8
    end

    it 'returns a collection of Products' do
      expect(products.last).to be_a(Zanox::Product)
    end

    it 'returns only Products that belongs to given shop' do
      expect(products.all? { |product| product.program[:id] == 5563 }).to be_truthy
    end
  end

  describe '#from_id' do
    let(:product) { Zanox::Product.from_id('0eca835e6c78e10c3b31a8146fc12324') }

    it 'returns a Product' do
      expect(product).to be_a(Zanox::Product)
    end

    it 'returns a Product matching given id' do
      expect(product.pid).to eq('0eca835e6c78e10c3b31a8146fc12324')
    end
  end

  describe '#initialize' do
    let(:data) do
      {
        "@id"      => "7f3b1f59484c49b8cbf6b70356b20d6f",
        "name"     => "Nike - Jordan - Socken - Weiß",
        "modified" => "2015-04-28T03:06:58+02:00",
        "program"  => {"@id" => "7408", "$" => "Asos.com DE"},
        "price"    => 17.99,
        "currency" => "EUR",
        "trackingLinks" => { "trackingLink" =>
          [
            {
              "@adspaceId" => "1009338",
              "ppv" => "http://ad.zanox.com/ppv/?22436292C14041752&ULP=[[Nike/Nike-Jordan-Socks/Prod/pgeproduct.aspx?iid=4955490&istCompanyId=030f1ff6-3a15-4425-bccd-ba2bdee3fa38&istItemId=piiiarxql&istBid=t&channelref=affiliate]]&zpar9=[[43EEF0445509C7205827]]",
              "ppc" => "http://ad.zanox.com/ppc/?22436292C14041752&ULP=[[Nike/Nike-Jordan-Socks/Prod/pgeproduct.aspx?iid=4955490&istCompanyId=030f1ff6-3a15-4425-bccd-ba2bdee3fa38&istItemId=piiiarxql&istBid=t&channelref=affiliate]]&zpar9=[[43EEF0445509C7205827]]"
            }
          ]
        },
        "description"     => "Nike - Jordan - Socken - Weiß - Farbe:Weiß",
        "descriptionLong" => "ÜBER MICH Hauptmaterial: 58% Baumwolle, 39% Nylon, 3% Elastan        SO PFLEGEN SIE MICH Wie auf dem Pflegeetikett angegeben in der Maschine waschen",
        "manufacturer"    => "Nike",
        "deliveryTime"    => "2 to 4 days",
        "category" => {"@id" => "3230000", "$" => "Bodywear & Lingerie"},
        "image"    => {"large" => "http://images.asos-media.com/inv/media/0/9/4/5/4955490/white/image1xxl.jpg"},
        "shippingCosts" => 3,
        "shipping"      => 3,
        "merchantCategory"  => "Startseite / Herren / Nike / Unterwäsche & Socken",
        "merchantProductId" => 3420722
      }
    end

    let(:invalid_data) do
      obj = data.dup
      obj['image'] = nil
      obj['price'] = nil
      obj
    end

    context 'valid input' do
      it 'creates a new instance of Product' do
        product = Zanox::Product.new(data)
        expect(product.price).to          be_a(Float)
        expect(product.shipping_costs).to be_a(Float)
        expect(product.delivery_time).to  eq 4
        expect(product.description).to    eq 'ÜBER MICH Hauptmaterial: 58% Baumwolle, 39% Nylon, 3% Elastan        SO PFLEGEN SIE MICH Wie auf dem Pflegeetikett angegeben in der Maschine waschen'
        expect(product.tracking_link).to  eq 'http://ad.zanox.com/ppc/?22436292C14041752&ULP=[[Nike/Nike-Jordan-Socks/Prod/pgeproduct.aspx?iid=4955490&istCompanyId=030f1ff6-3a15-4425-bccd-ba2bdee3fa38&istItemId=piiiarxql&istBid=t&channelref=affiliate]]&zpar9=[[43EEF0445509C7205827]]'
        expect(product.images).to         be_a(Hash)
        expect(product.images[:small]).to be_nil
        expect(product.images[:large]).to eq 'http://images.asos-media.com/inv/media/0/9/4/5/4955490/white/image1xxl.jpg'
      end
    end

    context 'invalid input' do
      it 'creates a new instance of Product' do
        product = Zanox::Product.new(invalid_data)
        expect(product.price).to                 eq 0.0
        expect(product.images.values.compact).to eq []
      end
    end
  end
end
