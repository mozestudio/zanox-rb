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
  module API
    include HTTParty
    logger  Logger.new
    base_uri 'http://api.zanox.com'

    class << self
      attr_accessor :debug

      def logger
        @logger ||= Logger.new
      end

      def debug?
        !!@debug
      end

      def debug!
        @debug = true
      end

      def request(method, options = {}, headers = {})
        if Session.secret_key
          method_path = method[0] == '/' ? method : "/#{method}"
          timestamp, nonce, signature = fingerprint_of(method_path, options)
          headers.merge!({
            'Authorization' => "ZXWS #{Session.connect_id}:#{signature}",
            'Date'          => timestamp,
            'nonce'         => nonce
          })
        else
          options.merge!({ 'connectId' => Session.connect_id })
        end

        logger.info "Params:  #{options.inspect}"
        logger.info "Headers: #{headers.inspect}"
        response = get("/json/2011-03-01/#{method}", query: options, headers: headers)
        Response.new(response)
      end

      private
      def fingerprint_of(method, options, verb = 'GET')
        timestamp = get_timestamp
        nonce     = get_nonce
        params    = ''#?' + URI.encode_www_form(options)
        signature = create_signature(Session.secret_key, "#{verb}#{method.downcase}#{params}#{timestamp}#{nonce}")
        [timestamp, nonce, signature]
      end

      def get_timestamp
        Time.now.strftime('%a, %e %b %Y %T %Z')
      end

      def get_nonce
        Digest::MD5.hexdigest((Time.new.usec + rand()).to_s)
      end

      def create_signature(secret_key, string_to_sign)
        digest = OpenSSL::HMAC.digest('sha1', secret_key, string_to_sign)
        Base64.encode64(digest)[0..-2]
      end
    end
  end
end
