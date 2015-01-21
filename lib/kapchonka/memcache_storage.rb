module Kapchonka

  class Storage
    class << self

      def save! key, value
        memcache = Kapchonka.driver
        memcache.set key.to_s, value.to_s, Kapchonka.expire
      end

      def get key
        Kapchonka.driver.get key.to_s
      end

      def remove! key
        Kapchonka.driver.delete key.to_s
      end

    end

  end

end