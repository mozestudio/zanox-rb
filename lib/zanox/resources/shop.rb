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
  class Shop < Item
    attr_reader :pid, :name, :rank, :description, :excerpt, :products_count,
      :regions, :categories, :url, :image, :currency, :available, :terms, :policies

    ###################
      # - pid            (Integer)  Shop ID
      # - name           (String)   The name of the product
      # - rank           (Float)    The rank of the shop
      # - description    (HTML)     The description of the shop
      # - excerpt        (String)   A short description of the shop
      # - products_count (Integer)  The number of products in stock
      # - regions        (String[]) A collection of regions where the shop is located
      # - categories     (String[]) A collection of the main categories of products
      # - url            (String)   The direct link to the shop
      # - image          (String)   An image representing the shop
      # - currency       (String)   The currency used inside the shop
      # - terms          (HTML)     The terms applied by the shop
      # - policies       (String[]) A collection of the policies followed by the shop
    ###################
    def initialize(data)
      @pid            = data['@id'].to_i
      @name           = data['name']
      @rank           = data['adrank'].to_f
      @description    = strip_cdata(data['descriptionLocal'])
      @excerpt        = data['description']
      @products_count = data['products'].to_i
      @regions        = [data['regions'].try { |r| r.map(&:values) }].flatten.compact
      @categories     = [].tap do |categories|
        [data['categories'].try { |p| p[0]['category'] }].flatten.each do |category|
          categories << {
            id:   category['@id'],
            name: category['$'],
          }
        end
      end
      @url            = data['url']
      @image          = data['image']
      @currency       = data['currency']
      @terms          = strip_cdata(data['terms'])
      @policies       = [].tap do |policies|
        [data['policies'].try { |p| p['policy'] }].flatten.each do |policy|
          policies << {
            id:   policy['@id'],
            name: policy['$'],
          } if policy
        end
      end
    end

    class << self
      def find(param, args = {})
        param.is_a?(Numeric) ? find_by_id(param) : find_by_keyword(param)
      end

      def find_by_id(id, args = {})
        response = ::Zanox::API.request("programs/program/#{id}", args)
        response.program_item.map { |program| new(program) }
      end

      def find_by_keyword(keyword, args = {})
        args.merge!({ q: keyword })
        response = API.request(:programs, args)
        response.program_items.map { |program| new(program) }
      end

      # TODO: we could cache these results
      def confirmed_shops
        confirmed_ids.map { |id| find(id) }.flatten
      end

      private
      def confirmed
        adspaces     = AdSpace.find.first
        applications = ProgramApplication.find(adspace: adspaces.pid)
        applications.select { |application| application.status == 'confirmed' }
      end

      def confirmed_ids
        confirmed.map { |application| application.program[:id] }
      end
    end

    private
    def strip_cdata(s)
      s ? s.gsub(/<!\[CDATA\[(.*)\]\]>/, '\1') : s
    end
  end
end
