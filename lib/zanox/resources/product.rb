#--
# Copyright(C) 2015 Giovanni Capuano <webmaster@giovannicapuano.net>
#
# Redistribution and use in source and binary forms, with or without modification, are
# permitted provided that the following conditions are met:
#
#    1. Redistributions of source code must retain the above copyright notice, this list of
#       conditions and the following disclaimer.
#
# THIS SOFTWARE IS PROVIDED BY Giovanni Capuano ''AS IS'' AND ANY EXPRESS OR IMPLIED
# WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
# FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL Giovanni Capuano OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
# ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
# NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#
# The views and conclusions contained in the software and documentation are those of the
# authors and should not be interpreted as representing official policies, either expressed
# or implied, of Giovanni Capuano.
#++

module Zanox
  class Product < Item
    attr_reader :pid, :name, :program, :description, :excerpt, :manufacturer, :category,
      :images, :currency, :price, :price_old, :shipping_costs, :delivery_time, :tracking_link
    attr_accessor :pagination

    ###################
      # - pid            (String)   Product ID
      # - name           (String)   The name of the product
      # - program        (Hash)     Hash containing the id and the name of the shop which sells this product (e.g. EuronicsIT)
      # - description    (HTML)     The description of the product
      # - excerpt        (String)   A short description of the product
      # - manufacturer   (String)   The manufacturer of the product (e.g. Apple)
      # - images         (String[]) A collection of images representing the product in different sizes
      # - currency       (String)   The currency used to calculate the price
      # - price          (Float)    The price of the product calculated with the relative currency
      # - shipping_costs (Float)    The price of the shipping
      # - delivery_time  (Integer)  The number of the days required by the shop to deliver the product
      # - tracking_link  (String )  The link that redirects to the advertiser's shop
    ###################
    def initialize(data)
      @pid            = data['@id']
      @name           = data['name']
      @program        = {
        id:   data['program']['@id'].to_i,
        name: data['program']['$']
      }
      @description    = strip_cdata(data['descriptionLong'])
      @excerpt        = data['description']
      @manufacturer   = data['manufacturer']
      @category       = data['merchantCategory']
      @images         = {
        small:  data['image'].try { |i| i['small']  },
        medium: data['image'].try { |i| i['medium'] },
        large:  data['image'].try { |i| i['large']  },
      }
      @currency       = data['currency']
      @price          = data['price'].to_f
      @price_old      = data['priceOld'].to_f
      @shipping_costs = data['shippingCosts'].try(:to_f)
      @delivery_time  = only_numbers(data['deliveryTime'])
      @tracking_link  = data['trackingLinks'].try { |d| d['trackingLink'] }.try { |d| d[0] }.try { |d| d['ppc'] }
    end

    class << self
      def find(keyword, args = {})
        args.merge!({ q: keyword })
        response = API.request(:products, args)
        from_product_items(response)
      end

      def from_shop(shop_id, args = {})
        args.merge!({ programs: shop_id })
        response = API.request(:products, args)
        from_product_items(response)
      end

      def from_id(product_id, args = {})
        response = API.request("products/product/#{product_id}", args)
        new(response.product_item.first)
      end

      private
      def from_product_items(response)
        response.product_items.map do |product|
          item = new(product)
          item.pagination = { page: response.page, items: response.items, total: response.total }
          item
        end
      end
    end

    private
    def strip_cdata(s)
      s ? s.gsub(/<!\[CDATA\[(.*)\]\]>/, '\1') : s
    end

    def only_numbers(s)
      return s if s.is_a?(Numeric)
      s ? s.scan(/\d+/).last.to_i : s
    end
  end
end
