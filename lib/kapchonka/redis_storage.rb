module Kapchonka

  class Storage
    class << self

      def save! key, value
        @redis = Kapchonka.redis
        @redis.set key.to_s, value.to_s
        @redis.expire key, Kapchonka.expire
      end

      def get key
        Kapchonka.redis.get key.to_s
      end

      def remove! key
        Kapchonka.redis.del key.to_s
      end

    end

  end

end