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
  class ProgramApplication < Item
    attr_reader :pid, :program, :adspace, :status, :allow_tpv

    ###################
      # - pid            (Integer)  ProgramApplication ID
      # - program        (Hash)     Infos about the program (activation status, id and name)
      # - adspace        (Hash)     Infos about the adspace (id and name)
      # - status         (String)   The status of the program (open, confirmed, rejected, deferred, waiting, blocked, terminated, canceled, called, declined, deleted)
      # - allow_tpv      (Boolean)
    ###################
    def initialize(data)
      super(data)

      @pid     = data['@id'].to_i
      @program = {
        active: data['program']['@active'] == 'true',
        id:     data['program']['@id'].to_i,
        name:   data['program']['$']
      }
      @adspace = {
        id:     data['adspace']['@id'],
        name:   data['adspace']['$']
      }
      @status    = data['status']
      @allow_tpv = data['allowTpv']
    end

    class << self
      def find(args = {})
        response = API.request(:programapplications, args)
        response.program_application_items.map { |program_application| new(program_application) }
      end
    end
  end
end
