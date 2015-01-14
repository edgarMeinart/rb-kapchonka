require 'base64'
require 'RMagick'
include Magick


module Kapchonka

  module Utils

    def self.generate_random_captcha_key
      rand(10 ** 5).to_s
    end

    def self.generate_random_equation step_count = 1
      operators = %w(+ - *)
      equation = []
      step_count.times do |i|
        equation << rand(10) if i == 0
        equation << operators[rand(3)]
        equation << rand(10)
      end
      equation.join(' ')
    end

    def self.generate_kapchonka_image_base64(captcha_key)
      final_image = Magick::Image.new(180, 90) { self.format = 'PNG' }
      text = Magick::Image.new(180, 90)

      # Draw Numbers
      gc = Magick::Draw.new
      gc.annotate(text, 0,0,0,0, captcha_key) do
        gc.gravity = CenterGravity
        self.pointsize = 25
        self.font_family = 'Arial'
        self.font_weight = BoldWeight
        self.stroke = 'transparent'
        self.fill = 'black'
      end

      final_image.composite!(text.rotate(rand(45)).wave( rand(50), 200 + rand(100)), CenterGravity, HardLightCompositeOp)

      Base64.encode64(final_image.to_blob).gsub("\n",'')
    end

  end

end