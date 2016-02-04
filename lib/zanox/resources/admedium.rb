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
  class AdMedium < Item
    attr_reader :pid, :name, :adrank, :type, :program, :title, :description, :category, :tracking_links

    ###################
      # - pid            (Integer)  AdMedium ID
      # - name           (String)   The name of the admedium
      # - adrank         (String)   The adrank of the admedium
      # - type           (String)   The type of the admedium (html, script, image, imagetext, text)
      # - program        (String)   The program of the admedium
      # - title          (String)   The title of the admedium
      # - description    (String)   The description of the admedium
      # - category       (String)   The category of the admedium (GET /admedia/categories/program/{id})
      # - tracking_links (Hash[])   The list of the tracking links for the admedium
    ###################
    def initialize(data)
      @pid            = data['@id'].to_i
      @name           = data['name']
      @adrank         = data['adrank']
      @type           = data['admediumType']
      @program        = {
        id:   data['program']['@id'].to_i,
        name: data['program']['$']
      }
      @title          = data['title']
      @description    = data['description']
      @category       = parse_category(data)
      @tracking_links = parse_tracking_links(data)
    end

    class << self
      def find(args = {})
        response = API.request(:admedia, args)
        [response.admedium_items].flatten.map { |admedium| new(admedium) }
      end
    end

    private

    def parse_category(data)
      return nil unless data['category']

      {
        id:   data['category']['@id'].to_i,
        name: data['category']['$']
      }
    end

    def parse_tracking_links(data)
      return [] if data['trackingLinks'].empty?

      data['trackingLinks'].map do |tl|
        tl = tl[1][0]
        tracking_link = {
          adspace_id: tl.delete('@adspaceId').to_i,
        }
        tl.each { |type, url| tracking_link[type.to_sym] = url }
        tracking_link
      end
    end
  end
end
