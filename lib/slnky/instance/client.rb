require 'fog/aws'

module Slnky
  module Instance
    class Client < Slnky::Client::Base
      def initialize

      end

      def find(name_or_id)
        if name_or_id =~ /^i-\d{8,12}$/
          by_id(name_or_id)
        else
          by_name(name_or_id)
        end
      end

      def terminate(id)
        instance = by_id(id)
        return instance.destroy if instance && config.production?
        false
      rescue => e
        log.debug "Slnky::Instance::Client: ERROR: #{e.message} at #{e.backtrace.first}"
        false
      end

      protected

      def by_id(id)
        ec2.servers.get(id)
      end

      def by_name(name)
        ec2.servers.all('tag:Name'=>name)
      end

      def ec2
        @ec2 ||= begin
          options = {provider: 'AWS', aws_secret_access_key: config.aws.secret, aws_access_key_id: config.aws.key}
          Fog::Compute.new(options.merge({region: config.aws.region}))
        end
      end
    end
  end
end
