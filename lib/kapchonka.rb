require('active_support/all')

module Kapchonka

  autoload :Utils, 'kapchonka/utils'
  autoload :ViewHelper, 'kapchonka/view_helper'
  autoload :ControllerHelper, 'kapchonka/controller_helper'

  mattr_accessor :store
  mattr_accessor :image_width
  mattr_accessor :image_height
  mattr_accessor :font_family
  mattr_accessor :font_size
  mattr_accessor :font_color
  mattr_accessor :stroke_width
  mattr_accessor :stroke_color
  mattr_accessor :operands
  mattr_accessor :operant_max_number


  def self.setup
    yield self
  end

  class << self

    def image_width
      @image_width || 180
    end

    def image_height
      @image_height || 90
    end

    def font_family
      @font_size || 'Arial'
    end

    def font_size
      @font_size || 24
    end

    def font_color
      @font_color || 'black'
    end

    def stroke_width
      @stroke_width || 0
    end

    def stroke_color
      @stroke_color || 'transparent'
    end

    def operant_max_number
      @operant_max_number || 10
    end

    def operands
      @operands || %w(+ - *)
    end

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