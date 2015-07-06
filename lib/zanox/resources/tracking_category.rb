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
  class TrackingCategory < Item
    attr_reader :pid, :program, :adspace, :transaction_type, :sale_fixed, :sale_percent

    ###################
      # - pid              (Integer)  AdSpace ID
      # - program          (Hash)     The program in input
      # - adspace          (Hash)     The adspace in input
      # - transaction_type (String)   The type of the transaction (leads, sales)
      # - sale_fixed       (Float)    The fixed value of the sale
      # - sale_percent     (Float)    The percent value of the sale
    ###################
    def initialize(data)
      @pid           = data['@id'].to_i
      @program       = {
        id:   data['program']['@id'].to_i,
        name: data['program']['$']
      }
      @adspace        = {
        id:   data['adspace']['@id'].to_i,
        name: data['adspace']['$']
      }
      @transaction_type = data['transactionType']
      @sale_fixed       = data['sale_fixed']
      @sale_percent     = data['sale_percent']
    end

    class << self
      def find(program_id, adspace_id)
        response = API.request("programapplications/program/#{program_id}/adspace/#{adspace_id}/trackingcategories")
        response.tracking_category_item.map { |tracking_category| new(tracking_category) }
      end
    end
  end
end
