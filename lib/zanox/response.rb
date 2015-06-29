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
  class Response
    attr_reader :response

    def initialize(response)
      @response = response

      status_code = @response.parsed_response['code']
      if status_code
        if status_code >= 400 && status_code <= 499
          raise API::AccessDeniedError, @response.parsed_response['message']
        elsif status_code >= 100 && status_code <= 199
          raise API::InvalidRequestError, @response.parsed_response['reason']
        end
      end
    end

    def response
      @response.parsed_response
    end

    def inspect
      response
    end

    def method_missing(m, *args, &block)
      key = m.to_s
      response = @response[key] || @response["@#{key}"] || @response[camelize(key)]
      response.kind_of?(Hash) && response.length == 1 ? response.values.first : response
    end

    private
    def camelize(s)
      words = s.split('_')
      ([words.first] + words.drop(1).map(&:capitalize!)).join
    end
  end
end
