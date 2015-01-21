require 'spec_helper'
require 'redis'
require 'memcached'


describe Kapchonka do

  context 'Test storage' do
    before(:all) do
      Kapchonka.setup do |k|
        k.store = :test
      end
    end

    it 'should be test' do
      expect(Kapchonka.store).to eql :test
    end

    it 'store key with value' do
      Kapchonka::Storage.save! :test_key, :test_value
      expect( Kapchonka::Storage.get :test_key ).to eql :test_value
    end

    it 'remove from storage' do
      expect( Kapchonka::Storage.remove! :test_key).to be_nil
    end

  end


  context 'Redis storage' do
    before(:all) do
      redis = Redis.new host: '127.0.0.1', port: 6379
      Kapchonka.setup do |k|
        k.store = :redis
        k.driver = redis
      end
    end

    it 'should be test' do
      expect(Kapchonka.store).to eql(:redis)
    end

    it 'store key with value' do
      Kapchonka::Storage.save! "test_key", "test_value"
      expect( Kapchonka::Storage.get "test_key" ).to eql "test_value"
    end

    it 'remove from storage' do
      expect( Kapchonka::Storage.remove! "test_key").to eql(1)
    end

  end


  context 'Memcache storage' do
    before(:all) do
      memcache = Memcached.new("localhost:11211")
      Kapchonka.setup do |k|
        k.store = :memcache
        k.driver = memcache
      end
    end

    it 'should be test' do
      expect(Kapchonka.store).to eql :memcache
    end

    it 'store key with value' do
      Kapchonka::Storage.save! "test_key", "test_value"
      expect( Kapchonka::Storage.get "test_key" ).to eql "test_value"
    end

    it 'remove from storage' do
      Kapchonka::Storage.remove! "test_key"
      expect(Kapchonka::Storage.get "test_key").to raise_exception
    end

  end

end