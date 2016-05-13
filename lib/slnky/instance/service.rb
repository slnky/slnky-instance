module Slnky
  module Instance
    class Service < Slnky::Service::Base
      attr_writer :client
      def client
        @client ||= Slnky::Instance::Client.new
      end

      subscribe 'slnky.service.test', :handle_test
      # you can also subscribe to heirarchies, this gets
      # all events under something.happened
      # subscribe 'something.happened.*', :other_handler

      def handle_test(name, data)
        name == 'slnky.service.test' && data.hello == 'world!'
      end
    end
  end
end
