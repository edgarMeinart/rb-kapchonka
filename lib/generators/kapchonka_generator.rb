require 'rails/generators'

class KapchonkaGenerator < Rails::Generators::Base
  include Rails::Generators::Migration

  def self.source_root
    @source_root ||= File.expand_path(File.join(File.dirname(__FILE__), 'templates/'))
  end

  def create_partial
    template 'partial.slim', File.join('app/views', 'shared', '_kapchonka_partial.slim')
  end

  def create_config
    template 'config.rb', File.join('config/initializers', '','kapchonka.rb')
  end

  def create_locale
    template 'kapchonka.en.yml', File.join('config/locales', '','kapchonka.en.yml')
  end
end