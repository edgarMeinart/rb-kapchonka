module Kapchonka

  module ControllerHelper

    def kapchonka_valid?
      result = params[:kapchonka].to_s == Storage.get(:kapchonka_result)
      destroy_kapchonka! if result
      result
    end

    def generate_kapchonka
      Storage.session = session if Kapchonka.store == :session
      equation = Utils.generate_random_equation(rand(4) + 1)
      Storage.save! :kapchonka_equation, equation
      Storage.save! :kapchonka_result, eval(equation).to_s
    end

    def destroy_kapchonka!
      Storage.remove! :kapchonka_equation
      Storage.remove! :kapchonka_result
    end

  end

end