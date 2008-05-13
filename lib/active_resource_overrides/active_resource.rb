require 'active_resource/connection'
require 'cgi'
require 'set'

module ActiveResource
  class Base
    class << self
      # Sets the +open_timeout+ variable to be used for HTTP connections.
      # If not set, the default value for HTTP::Net#open_timeout is used (60)
      def open_timeout
        if defined?(@open_timeout)
          @open_timeout
        elsif superclass != Object && superclass.open_timeout
          superclass.open_timeout
        end
      end
      
      # Sets the +read_timeout+ argument to be used for HTTP connections.
      def open_timeout=(open_timeout)
        @connection = nil
        @open_timeout = open_timeout
      end
      
      # Gets the +read_timeout+ setting to be used for HTTP connections.
      # If not set, the default value for HTTP::Net#read_timeout is used (60)
      def read_timeout
        if defined?(@read_timeout)
          @read_timeout
        elsif superclass != Object && superclass.read_timeout
          superclass.read_timeout
        end
      end

      # Sets the +read_timeout+ argument to be used for HTTP connections.
      def read_timeout=(read_timeout)
        @connection = nil
        @read_timeout = read_timeout
      end
      
      def connection(refresh = false)
        if defined?(@connection) || superclass == Object
          if refresh || @connection.nil?
            @connection = Connection.new(site, format) 
            @connection.read_timeout = read_timeout if read_timeout
            @connection.open_timeout = open_timeout if open_timeout
          end
          @connection
        else
          superclass.connection
        end
      end
    end
  end
end
