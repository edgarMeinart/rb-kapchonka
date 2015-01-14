module Kapchonka

  class Storage
    class << self

      attr_accessor :session

      def save! key, value
        session[key] = value
      end

      def get key
        session[key]
      end

      def remove! key
        session[key] = nil
      end

    end

  end

end