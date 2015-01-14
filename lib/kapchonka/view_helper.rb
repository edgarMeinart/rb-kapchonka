module Kapchonka

  module ViewHelper

    def show_kapchonka
      image_data = Utils.generate_kapchonka_image_base64 Storage.get(:kapchonka_equation)
      render partial: 'shared/kapchonka_partial', locals: { image_data: image_data, input_name: 'kapchonka' }
    end

  end

end