require 'base64'
require 'RMagick'
include Magick


module Kapchonka

  module Utils

    def self.generate_random_equation step_count = 1
      equation = []
      step_count.times do |i|
        equation << rand(Kapchonka.operant_max_number) if i == 0
        equation << Kapchonka.operands[rand(Kapchonka.operands.size)]
        equation << rand(Kapchonka.operant_max_number)
      end
      equation.join(' ')
    end

    def self.generate_kapchonka_image_base64(captcha_key)
      final_image = Magick::Image.new(Kapchonka.image_width, Kapchonka.image_height) { self.format = 'PNG' }
      text = Magick::Image.new(Kapchonka.image_width, Kapchonka.image_height)

      gc = Magick::Draw.new
      gc.annotate(text, 0,0,0,0, captcha_key) do
        gc.gravity          = CenterGravity
        self.fill           = Kapchonka.font_color
        self.pointsize      = Kapchonka.font_size
        self.font_family    = Kapchonka.font_family
        self.font_weight    = BoldWeight
        if Kapchonka.stroke_width > 0
          self.stroke_width = Kapchonka.stroke_width
          self.stroke       = Kapchonka.stroke_color
        end
      end

      final_image.composite!(text.rotate(rand(45)).wave( rand(50), 200 + rand(100)), CenterGravity, HardLightCompositeOp)

      Base64.encode64(final_image.to_blob).gsub("\n",'')
    end

  end

end