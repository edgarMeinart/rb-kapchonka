require('active_support/all')

module Kapchonka

  autoload :Utils, 'kapchonka/utils'
  autoload :ViewHelper, 'kapchonka/view_helper'
  autoload :ControllerHelper, 'kapchonka/controller_helper'

  mattr_accessor :store

  def self.setup
    yield self
  end

  class << self

    def store
       @store || :session
    end

    def store= type
      require "kapchonka/#{type}_storage.rb" unless defined?(Rails)
      @store = type
    end

  end

end

require 'kapchonka/engine' if defined?(Rails)