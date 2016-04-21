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
  class AdSpace < Item
    attr_reader :pid, :name, :url, :description, :type, :visitors, :impressions,
      :scope, :regions, :categories, :language, :check_number

    ###################
      # - pid            (Integer)  AdSpace ID
      # - name           (String)   The name of the adspace
      # - url            (String)   The URL to the adspace
      # - description    (String)   The description of the adspace
      # - type           (String)   The type of the adspace (website, email, searchengine)
      # - visitors       (Integer)  How many visitors Zanox tracked for you
      # - impressions    (Integer)  The number of impressions of the adspace
      # - scope          (String)   The scope of the adspace (private, bussiness)
      # - regions        (String[]) The regions where the adspace works
      # - categories     (String[]) The categories of the adspace
      # - language       (String)   The language used inside the adspace
      # - check_number   (Integer)
    ###################
    def initialize(data)
      super(data)

      @pid           = data['@id'].to_i
      @name          = data['name']
      @url           = data['url']
      @description   = data['description']
      @type          = data['adspaceType']
      @visitors      = data['visitors'].to_i
      @impressions   = data['impressions'].to_i
      @scope         = data['scope']
      @regions       = [data['regions'].try { |r| r.map(&:values) }].flatten.compact
      @categories    = [].tap do |categories|
        categories_ = data['categories'].try { |p| p[0]['category'] }
        data['categories'].try { |p| p[0]['category'] }.each do |category|
          categories << {
            id:   category[0],
            name: category[1],
          }
        end
      end
      @language      = data['language']
      @check_number  = data['checkNumber']
    end

    class << self
      def find(args = {})
        response = API.request(:adspaces, args)
        response.adspace_items.map { |adspace| new(adspace) }
      end
    end
  end
end
