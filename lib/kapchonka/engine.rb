require 'rails'
require 'kapchonka'

module Kapchonka

  class Engine < ::Rails::Engine

    config.before_initialize do
      case Kapchonka.store
        when :test
          require 'kapchonka/test_storage.rb'
        when :session
          include ActionDispatch::Session
          require 'kapchonka/session_storage.rb'
        else
          raise StandardError.new("Unknown store: #{Kapchonka.store}")
      end
    end

    config.after_initialize do
      ActionView::Base.send(:include, Kapchonka::ViewHelper)
    end

  end

end