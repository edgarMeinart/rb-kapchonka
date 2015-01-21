require('active_support/all')

module Kapchonka

  autoload :Utils, 'kapchonka/utils'
  autoload :ViewHelper, 'kapchonka/view_helper'
  autoload :ControllerHelper, 'kapchonka/controller_helper'

  mattr_accessor :store
  @@store = :session

  mattr_accessor :redis

  mattr_accessor :expire
  @@expire = 3600

  mattr_accessor :image_width
  @@image_width = 180

  mattr_accessor :image_height
  @@image_height = 90

  mattr_accessor :font_family
  @@font_family = 'Arial'

  mattr_accessor :font_size
  @@font_size = 24

  mattr_accessor :font_color
  @@font_color = 'black'

  mattr_accessor :stroke_width
  @@stroke_width = 0

  mattr_accessor :stroke_color
  @@stroke_color = 'transparent'

  mattr_accessor :operands
  @@operands = %w(+ - *)

  mattr_accessor :operant_max_number
  @@operant_max_number = 10

  def self.setup
    yield self
  end

  class << self

    def store= type
      require "kapchonka/#{type}_storage.rb" unless defined?(Rails)
      @store
    end

  end

end

require 'kapchonka/engine' if defined?(Rails)