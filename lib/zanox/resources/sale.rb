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
  class Sale < Item
    attr_reader :pid, :review_state, :tracking_date, :click_date, :adspace, :admedium,
      :program, :click_id, :amount, :commission, :currency, :review_note

    ###################
      # - pid            (String)   Sale ID
      # - review_state   (String)   State of the sale's review from the advertiser's side
      # - tracking_date  (Date)     The date when the review has been done
      # - click_date     (Date)     The date when the buyer bought the item
      # - adspace        (Hash)     Infos about the adspace (id and name)
      # - admedium       (Hash)     How the buyer bought the item
      # - program        (Hash)     Hash containing the id and the name of the shop which sells this product (e.g. EuronicsIT)
      # - click_id       (Integer)  Click id
      # - amount         (Float)    How much the buyer paid the item
      # - commission     (String)   How much you get from the purchase
      # - currency       (String)   The currency used for the purchase (i.e. EUR)
      # - review_note    (String)   Note leaved by the advertiser who reviewed the purchase
    ###################
    def initialize(data)
      super(data)

      @pid            = data['@id']
      @review_state   = data['reviewState']
      @tracking_date  = Date.parse(data['trackingDate'])
      @click_date     = Date.parse(data['clickDate'])
      @adspace        = {
        id:     data['adspace']['@id'],
        name:   data['adspace']['$']
      }
      @admedium = {
        id:     data['admedium']['@id'],
        name:   data['admedium']['$']
      }
      @program  = {
        id:     data['program']['@id'],
        name:   data['program']['$']
      }
      @click_id    = data['clickId'].to_i
      @amount      = data['amount'].to_f
      @commission  = data['commission'].to_f
      @currency    = data['currency']
      @review_note = data['reviewNote']
      @gpps        = {}
      data['gpps']['gpp'].each {|gpp| @gpps[gpp['@id']] = gpp["$"] }
    end

    class << self
      def find_by_date(date, args = {})
        response = API.request("reports/sales/date/#{date.to_s}", args)

        [response.sale_items].flatten.map { |sale_item| new(sale_item) }
      end
    end
  end
end
