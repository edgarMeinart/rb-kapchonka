require 'spec_helper'

describe Kapchonka do

  before(:all) do
    Kapchonka.setup do |s|
      s.store = :test
    end
  end

  describe 'Test storage' do

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


end