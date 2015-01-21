require 'spec_helper'
require 'redis'

describe Kapchonka do

  context 'Test storage' do

    before(:all) do
      Kapchonka.setup do |s|
        s.store = :test
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
      Kapchonka.setup do |s|
        s.store = :redis
        s.redis = redis
      end
    end

    it 'should be test' do
      expect(Kapchonka.store).to eql :redis
    end

    it 'store key with value' do
      Kapchonka::Storage.save! "test_key", "test_value"
      expect( Kapchonka::Storage.get "test_key" ).to eql "test_value"
    end

    it 'remove from storage' do
      expect( Kapchonka::Storage.remove! "test_key").to eql(1)
    end

  end


end