module Kapchonka

  class Storage

    class << self

      attr_accessor :test_storage

      def save! key, value
        @test_storage = { key => value }
      end

      def get key
        @test_storage[key]
      end

      def remove! key
        @test_storage = nil
      end

    end

  end

end