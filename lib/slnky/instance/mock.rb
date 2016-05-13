module Slnky
  module Instance
    class Mock < Slnky::Instance::Client
      # unless there's something special you need to do in the initializer
      # use the one provided by the actual client object
      # def initialize
      #
      # end

      def find(name)
        if name == 'blarg'
          []
        elsif name == 'tools-ops'
          [DeepStruct.new({id: 'i-87654321', tags: {'Name' => 'tools-ops'}})]
        end
      end

      def terminate(id)
        false if id == 'i-12345678'
        true if id == 'i-87654321'
      end
    end
  end
end
