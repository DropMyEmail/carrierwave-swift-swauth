require 'carrierwave'
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'swift', 'swauth_client'))

module CarrierWave
  module Storage
    class SwiftSwauth < Abstract

      # Public: Stores the file on Swift
      #
      # Examples
      #
      #   swift_swauth.store! <File>
      #   => nil
      #
      # Returns nothing
      def store!(file)
        write_opts = { content_type: file.content_type }
        client.create_object(identifier, write_opts, file)
      end

      # Public: Returns the object given the identifier
      #
      # Examples
      #
      #   swift_swauth.retrieve! 'foo'
      #   => <OpenStack::Swift::Container::Object>
      #
      # Returns an instance of OpenStack::Swift::COntainer::Object
      def retrieve!(file_identifier)
        client.object(file_identifier)
      end

      protected

      # Private: Returns the swift client for performing the operations
      #
      # Examples
      #
      #   swift_swauth.client
      #   => <Carrierwave::Swift::SwauthClient>
      #
      # Returns an instance of SwauthClient
      def client
        if @client.nil?
          @client = CarrierWave::Swift::SwauthClient.new
        end
        @client
      end

    end
  end
end
