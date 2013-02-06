# Public: Carrierwave storage adaptor for Openstack Swift
# Swift authentication is assumed to be on Swauth
module CarrierWave
  module Swift
    class SwauthClient
      SERVICE_TYPE = 'object-store'

      # Public: Constructor. Assumes all the needed variables are
      # found in the environment
      def initialize
        @swift_opts = {
          user:      ENV['SWIFT_USER'] || '',
          password:  ENV['SWIFT_PASSWORD'] || '',
          url:       ENV['SWIFT_URL'] || '',
          tenant:    ENV['SWIFT_TENANT'] || '',
          container: ENV['SWIFT_CONTAINER'] || ''
        }
      end

      # Public: Checks if the object exists in the container
      #
      # path - The String which represents the object
      #
      # Examples
      #
      #   swauth_client.object_exists 'foo'
      #   => true
      #
      # Returns a Boolean
      def object_exists?(path)
        container.object_exists? path
      end

      # Public: Creates the object given the path, options and data
      #
      # path - The String which represents the object
      # opts - The Hash which contains the options for the object
      # data - The File or String which represents the data
      #
      # Examples
      #
      #   swauth_client.create_object 'foo', {}, File.open('foo.pdf')
      #   => nil
      #
      # Returns nothing
      def create_object(path, opts={}, data)
        container.create_object path, opts, data
      end

      # Public: Deletes the object given the path
      #
      # path - The String which represents the object
      #
      # Examples
      #
      #   swauth_client.delete_object 'foo'
      #   => nil
      #
      # Returns nothing
      def delete_object(path)
        container.delete_object path
      end

      # Public: Returns the object given the path
      #
      # path - The String which represents the object
      #
      # Examples
      #
      #   swauth_client.object 'foo'
      #   => <OpenStack::Swift::Container::Object>
      #
      # Returns an instance of OpenStack::Swift::Container::Object
      def object(path)
        container.object path
      end

      protected

      # Private: Returns the container object for the connection
      #
      # Examples
      #
      #   swauth_client.container
      #   => <OpenStack::Swift::Container>
      #
      # Returns an instance of OpenStack::Swift::Container
      def container
        if @connection.nil?
          @connection = OpenStack::Connection.create(connection_opts)
        end
        @connection.container(@swift_opts[:container])
      end

      # Private: Returns the connection options
      #
      # Examples
      #
      #   swauth_client.connection_opts
      #   => {...}
      #
      # Returns a Hash of options
      def connection_opts
        {
          username: @swift_opts[:user],
          api_key: @swift_opts[:password],
          auth_url: @swift_opts[:url],
          authtenant_name: @swift_opts[:tenant],
          auth_method: @swift_opts[:password],
          service_type: SERVICE_TYPE
        }
      end
    end # class
  end
end
