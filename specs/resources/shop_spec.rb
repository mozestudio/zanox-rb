require_relative '../spec_helper'

describe Zanox::Shop do
  describe '#find' do
    let(:shops) { Zanox::Shop.find('zalando') }

    it 'finds shops by keyword' do
      expect(shops.length).to be > 0
    end

    it 'returns a collection of Shops' do
      expect(shops.last).to be_a(Zanox::Shop)
    end
  end

  describe '#confirmed' do
    let(:programs) { Zanox::Shop.instance_eval { confirmed } }

    it 'contains at least one program' do
      expect(programs.length).to be > 0
    end

    it 'contains only approved program' do
      expect(programs.all? { |program| program.status == 'confirmed' }).to be_truthy
    end
  end

  ## Well, this test will never work with the default API keys...
  # describe '#confirmed_shops' do
  #   let(:shops) { Zanox::Shop.confirmed_shops }

  #   it 'contains at least one shop' do
  #     expect(shops.length).to be > 0
  #   end

  #   it 'returns a collection of Shops' do
  #     expect(shops.last).to be_a(Zanox::Shop)
  #   end

  #   it 'returns only confirmed programs' do
  #     expect(shops.length).to be > 0
  #   end
  # end

  describe '#initialize' do
    let(:data) do
      {
        "@id"    => "2283",
        "name"   => "Amazon Buy VIP DE",
        "adrank" => 4.1,
        "applicationRequired" => true,
        "description"      => "Amazon BuyVIP – der Shopping Club für Fashion & Lifestyle. Verdienen Sie 6% Provision an unseren exklusiven Verkaufsaktionen mit Preisvorteilen von bis zu 70% auf begehrte Top Marken und Insider Labels sowie 1€ Provision für jedes neue Mitglied!",
        "descriptionLocal" => "<![CDATA[<p>    <strong>Sale-Vergütung jetzt auch für Bestandskunden! </strong></p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP</strong></p><p>    Amazon BuyVIP &ndash; der Shopping Club für Fashion &amp; Lifestyle. Der Zutritt zu Amazon BuyVIP ist limitiert: Nur registrierte Mitglieder erhalten Zugang zu exklusiven und zeitlich begrenzten Verkaufsaktionen mit Preisvorteilen von bis zu 70% gegenüber der UVP des Herstellers. Angeboten werden begehrte Top Marken und Insider Labels&nbsp; aus dem Bereich Fashion und Lifestyle.</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Produktsortiment</strong></p><p>    Das Sortiment umfasst Verkaufsaktionen mit folgenden Produkten:</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Damen-, Herren- und Kindermode</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Accessories wie Taschen, Schals, Schmuck und Sonnenbrillen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wellness- &amp; Beauty-Produkte</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Edle Wohnaccessoires und Möbel</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Publisher-Vorteile auf einen Blick</strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sale-Vergütung für Neu- &amp; Bestandskunden</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Conversionstarke Werbemittel, saisonal gepflegt</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cookie-Laufzeit: 30 Tage</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regelmäßiger Affiliate-Newsletter</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Saisonale Pflege aller Werbemittel</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Kundenvorteile auf einen Blick</strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Breites Angebot begehrter Top Marken und Insider Labels</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bis zu 70% Preisvorteil gegenüber der UVP des Herstellers</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Einfache Anmeldung mit dem Amazon Konto</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kostenlose &amp; unverbindliche Mitgliedschaft</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ein Warenkorb für alle Verkaufsaktionen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gratisversand ab 100 Euro Bestellwert</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bezahlung erst beim Versand der Bestellung</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Versand in 27 Länder</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Servicezeiten von 6 bis 24 Uhr</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30 Tage Rückgabegarantie</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10 Euro Gutschein für jeden eingeladenen Freund</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Provisionsmodell</strong></p><p>    &nbsp;</p><p>    Sale: 6% auf jeden bestätigten Sale (Neu- &amp; Bestandskunden)</p><p>    Lead: 1 EUR &nbsp;für jedes valide neue Mitglied<br />    &nbsp;</p><p>    Ab 1.500 Leads pro Monat erhalten Sie 1,50 EUR pro Lead und 6% pro Sale.</p><p>    &nbsp;</p><p>    <strong>Die Sale-Provisionen gelten auch für Bestandskunden!</strong><br />    <br />    &nbsp;</p><p>    &nbsp;</p><p>    <strong>Suchmaschinenmarketing</strong></p><p>    SEM darf nur nach ausdrücklicher Einwilligung von Amazon BuyVIP angewendet werden.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Verwendung der Standard Amazon BuyVIP Display-URL ist ausdrücklich untersagt. Sie benötigen eine eigene Domain.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wir weisen darauf hin, dass keine geschützten Brand Namen verwendet werden dürfen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Buchung von Brand Keywords der direkten Mitbewerber zu Amazon BuyVIP ist ausdrücklich untersagt</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Buchung von BuyVIP Brand Keywords (auch Falschschreibweisen) ist ausdrücklich untersagt</p><p>    Zuwiderhandlungen führen zum Ausschluss aus dem Amazon BuyVIP-Partnerprogramm!</p><p>    &nbsp;</p><p>    <strong>Was muss ich noch beachten, wenn ich Amazon BuyVIP bewerbe? </strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jegliche Veränderungen der Verlinkungen sind nicht gestattet. Dies betrifft vor allem das Anhängen der Zanox-ID, Download und Einfügen von Werbemitteln auf Drittseiten, usw.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Das Kommunizieren von Endpreisen aus dem Amazon BuyVIP Shop ist ausdrücklich untersagt.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Es ist nicht gestattet, die Freundschaftswerbung von Amazon BuyVIP zu bewerben.</p><p>    &middot;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Weiterhin nicht gestattet sind: Paidmails, Keyword Advertising, Forced Clicks, Meta-Netzwerke, Cashback&nbsp;</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Es ist nicht gestattet, gleichzeitig dieselbe Platzierung über das Amazon PartnerNet&nbsp; zu verlinken.</p><p>    Zuwiderhandlungen führen zum Ausschluss aus dem Amazon BuyVIP-Partnerprogramm!</p><p>    &nbsp;</p><p>    <strong>Kontakt</strong></p><p>    Für Fragen und Wünsche stehen wir Ihnen gerne zur Verfügung. Wenden Sie sich einfach an Ihren persönlichen Ansprechpartner:</p><p>    &nbsp;</p><p>    <strong>Adreana Starke</strong></p><p>    E-Mail: adreana@amazon.com<br />    &nbsp;</p>]]>",
        "products" => 0,
        "vertical" => {
          "@id" => "78",
          "$"   => "Retail&Shopping"
        },
        "regions" => [
          {
            "region" => "DE"
          }
        ],
        "categories" => [
          {
            "category" => [
              {
                "@id" => "11",
                "$"   => "Internet services"
              },
              {
                "@id" => "33",
                "$"   => "Clothing & Accessories"
              },
              {
                "@id" => "34",
                "$"   => "Shopping & Mail Order Shops"
              }
            ]
          }
        ],
        "startDate" => "2006-08-01T02:00:00+02:00",
        "url"       => "http://de.buyvip.com",
        "image"     => "http://ui.zanox.com/images/programs/2283/2283_lgo_buy_vip.jpg",
        "currency"  => "EUR",
        "status"    => "active",
        "terms"     => "<p>    <strong>Was muss ich noch beachten, wenn ich Amazon BuyVIP bewerbe? </strong></p><p>     </p><p>    · Jegliche Veränderungen der Verlinkungen sind nicht gestattet. Dies betrifft vor allem das Anhängen der Zanox-ID, Download und Einfügen von Werbemitteln auf Drittseiten, usw.</p><p>    · Das Kommunizieren von Endpreisen aus dem Amazon BuyVIP Shop ist ausdrücklich untersagt.</p><p>    · Weiterhin nicht gestattet sind: Paidmails, Keyword Advertising, Forced Clicks, Meta-Netzwerke, Cashback&nbsp;</p><p>    · Es ist nicht gestattet, gleichzeitig dieselbe Platzierung über das Amazon PartnerNet&nbsp; zu verlinken.</p><p>    · Es ist nicht gestattet, die Freundschaftswerbung von Amazon BuyVIP zu bewerben.</p><p>    . SEM: eingeschränkt, siehe Regelungen in Branding</p><p>     </p><p>    Zuwiderhandlungen führen zum Ausschluss aus dem Amazon BuyVIP-Partnerprogramm!</p>",
        "policies"  => {
          "policy" => [
            {
              "@id" => "102",
              "$"   => "Popups/Popunders allowed"
            },
            {
              "@id" => "106",
              "$"   => "Cashback/Loyalty allowed"
            },
            {
              "@id" => "105",
              "$"   => "Co-Registration allowed"
            },
            {
              "@id" => "103",
              "$"   => "Layers allowed"
            },
            {
              "@id" => "107",
              "$"   => "Exclusive zanox advertiser"
            }
          ]
        },
        "returnTimeLeads" => 2592000,
        "returnTimeSales" => 2592000
      }
    end

    let(:invalid_data) do
      obj = data.dup
      obj['regions']  = nil
      obj['policies'] = nil
      obj
    end

    context 'valid input' do
      it 'creates a new instance of Shop' do
        shop = Zanox::Shop.new(data)
        expect(shop.rank).to           eq 4.1
        expect(shop.products_count).to eq 0
        expect(shop.regions).to        eq ['DE']
        expect(shop.description).to    eq '<p>    <strong>Sale-Vergütung jetzt auch für Bestandskunden! </strong></p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP</strong></p><p>    Amazon BuyVIP &ndash; der Shopping Club für Fashion &amp; Lifestyle. Der Zutritt zu Amazon BuyVIP ist limitiert: Nur registrierte Mitglieder erhalten Zugang zu exklusiven und zeitlich begrenzten Verkaufsaktionen mit Preisvorteilen von bis zu 70% gegenüber der UVP des Herstellers. Angeboten werden begehrte Top Marken und Insider Labels&nbsp; aus dem Bereich Fashion und Lifestyle.</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Produktsortiment</strong></p><p>    Das Sortiment umfasst Verkaufsaktionen mit folgenden Produkten:</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Damen-, Herren- und Kindermode</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Accessories wie Taschen, Schals, Schmuck und Sonnenbrillen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wellness- &amp; Beauty-Produkte</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Edle Wohnaccessoires und Möbel</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Publisher-Vorteile auf einen Blick</strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Sale-Vergütung für Neu- &amp; Bestandskunden</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Conversionstarke Werbemittel, saisonal gepflegt</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Cookie-Laufzeit: 30 Tage</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Regelmäßiger Affiliate-Newsletter</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Saisonale Pflege aller Werbemittel</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Kundenvorteile auf einen Blick</strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Breites Angebot begehrter Top Marken und Insider Labels</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bis zu 70% Preisvorteil gegenüber der UVP des Herstellers</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Einfache Anmeldung mit dem Amazon Konto</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Kostenlose &amp; unverbindliche Mitgliedschaft</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Ein Warenkorb für alle Verkaufsaktionen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Gratisversand ab 100 Euro Bestellwert</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Bezahlung erst beim Versand der Bestellung</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Versand in 27 Länder</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Servicezeiten von 6 bis 24 Uhr</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 30 Tage Rückgabegarantie</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10 Euro Gutschein für jeden eingeladenen Freund</p><p>    &nbsp;</p><p>    <strong>Amazon BuyVIP Provisionsmodell</strong></p><p>    &nbsp;</p><p>    Sale: 6% auf jeden bestätigten Sale (Neu- &amp; Bestandskunden)</p><p>    Lead: 1 EUR &nbsp;für jedes valide neue Mitglied<br />    &nbsp;</p><p>    Ab 1.500 Leads pro Monat erhalten Sie 1,50 EUR pro Lead und 6% pro Sale.</p><p>    &nbsp;</p><p>    <strong>Die Sale-Provisionen gelten auch für Bestandskunden!</strong><br />    <br />    &nbsp;</p><p>    &nbsp;</p><p>    <strong>Suchmaschinenmarketing</strong></p><p>    SEM darf nur nach ausdrücklicher Einwilligung von Amazon BuyVIP angewendet werden.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Verwendung der Standard Amazon BuyVIP Display-URL ist ausdrücklich untersagt. Sie benötigen eine eigene Domain.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Wir weisen darauf hin, dass keine geschützten Brand Namen verwendet werden dürfen</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Buchung von Brand Keywords der direkten Mitbewerber zu Amazon BuyVIP ist ausdrücklich untersagt</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Die Buchung von BuyVIP Brand Keywords (auch Falschschreibweisen) ist ausdrücklich untersagt</p><p>    Zuwiderhandlungen führen zum Ausschluss aus dem Amazon BuyVIP-Partnerprogramm!</p><p>    &nbsp;</p><p>    <strong>Was muss ich noch beachten, wenn ich Amazon BuyVIP bewerbe? </strong></p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Jegliche Veränderungen der Verlinkungen sind nicht gestattet. Dies betrifft vor allem das Anhängen der Zanox-ID, Download und Einfügen von Werbemitteln auf Drittseiten, usw.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Das Kommunizieren von Endpreisen aus dem Amazon BuyVIP Shop ist ausdrücklich untersagt.</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Es ist nicht gestattet, die Freundschaftswerbung von Amazon BuyVIP zu bewerben.</p><p>    &middot;&nbsp; &nbsp;&nbsp;&nbsp;&nbsp; Weiterhin nicht gestattet sind: Paidmails, Keyword Advertising, Forced Clicks, Meta-Netzwerke, Cashback&nbsp;</p><p>    &middot;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Es ist nicht gestattet, gleichzeitig dieselbe Platzierung über das Amazon PartnerNet&nbsp; zu verlinken.</p><p>    Zuwiderhandlungen führen zum Ausschluss aus dem Amazon BuyVIP-Partnerprogramm!</p><p>    &nbsp;</p><p>    <strong>Kontakt</strong></p><p>    Für Fragen und Wünsche stehen wir Ihnen gerne zur Verfügung. Wenden Sie sich einfach an Ihren persönlichen Ansprechpartner:</p><p>    &nbsp;</p><p>    <strong>Adreana Starke</strong></p><p>    E-Mail: adreana@amazon.com<br />    &nbsp;</p>'
        expect(shop.excerpt).to        eq 'Amazon BuyVIP – der Shopping Club für Fashion & Lifestyle. Verdienen Sie 6% Provision an unseren exklusiven Verkaufsaktionen mit Preisvorteilen von bis zu 70% auf begehrte Top Marken und Insider Labels sowie 1€ Provision für jedes neue Mitglied!'
        expect(shop.terms).to          be_a(String)
        expect(shop.policies).to       be_a(Array)
      end
    end

    context 'invalid input' do
      it 'creates a new instance of Shop' do
        shop = Zanox::Shop.new(invalid_data)
        expect(shop.regions).to  eq []
        expect(shop.policies).to eq []
      end
    end
  end
end
