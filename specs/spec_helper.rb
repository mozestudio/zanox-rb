require 'zanox'
require 'vcr'
require 'webmock'
require 'rspec/collection_matchers'

Zanox::API::Session.connect_id = '802B8BF4AE99EBE00F41'
Zanox::API::Session.secret_key = 'fa4c0c2020Aa4c+ab9Ea0ec8d39E06/df2c5aa44'

VCR.configure do |config|
  config.cassette_library_dir = File.join(File.dirname(__dir__), 'specs', 'cassettes')
  config.hook_into :webmock
  config.default_cassette_options = { record: :new_episodes }
  config.configure_rspec_metadata!
end
