require 'net/https'
require 'date'
require 'time'
require 'uri'
require 'benchmark'

module ActiveResource
  class Connection
    attr_accessor :open_timeout, :read_timeout
    private
      # Creates new Net::HTTP instance for communication with
      # remote service and resources.
      def http_with_extra_config
        http = http_without_extra_config
        http.open_timeout = open_timeout if open_timeout
        http.read_timeout = read_timeout if read_timeout
        http
      end
      
      alias_method_chain :http, :extra_config
  end
end
