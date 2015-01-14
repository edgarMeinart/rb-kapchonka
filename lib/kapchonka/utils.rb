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
      grid = Magick::Image.new(200, 200) { self.background_color = "Transparent"}
      text = Magick::Image.new(180, 90)

      #Draw lines
      grid_gc = Magick::Draw.new
      grid_gc.stroke('red')
      100.times do |i|
        grid_gc.line(i * 10, 0, i * 10, 200)
      end
      grid_gc.stroke('blue')
      100.times do |i|
        grid_gc.line(0, i * 10, 200, i * 10)
      end
      grid_gc.draw(grid)

      # Draw Numbers
      gc = Magick::Draw.new
      gc.annotate(text, 0,0,0,0, captcha_key) do
        gc.gravity = CenterGravity
        self.pointsize = 25
        self.font_family = "Arial"
        self.font_weight = BoldWeight
        self.stroke = "none"
      end

      grid.composite!(grid.rotate(rand(180)), CenterGravity, HardLightCompositeOp)
      # grid.composite!(grid.rotate(rand(180)), CenterGravity, HardLightCompositeOp)
      text.composite!(grid.rotate(rand(180)), CenterGravity, HardLightCompositeOp)
      final_image.composite!(text, CenterGravity, HardLightCompositeOp)

      Base64.encode64(final_image.to_blob).gsub("\n",'')
    end

  end

end