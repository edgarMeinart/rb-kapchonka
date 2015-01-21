# Kapchonka

Simple match captcha for Rails 4

Live preview:
http://kapchonka.meinart.ninja

#### Rails Installation

Add this to your Gemfile:

~~~ ruby
     gem 'kapchonka'
~~~

Run the following command to install it:

~~~ console
    bundle install
~~~

Run the generator:

~~~ console
    rails generate kapchonka
~~~

Gem tested only on Rails 4
#### Recaptcha.configure

~~~ ruby
    Kapchonka.setup do |k|
        k.store = :session
    
        # k.image_width = 180
        # k.image_height = 90
        # k.font_family = 'Arial'
        # k.font_size = 24
        # k.font_size = 24
        # k.font_color = 'black'
        # k.stroke_width = 0
        # k.stroke_color = 'transparent'
        # k.operand = %w(+ - *)
        # k.operant_max_number = 10
    end
~~~

#### To use 'Kaptchonka'

##### View

Add captcha tag to each form you want to protect.

~~~ slim
    = simple_form_for @post, url: posts_path do |form|
        = render 'form', form: form
        hr
        = show_kapchonka
        hr
        = form.submit 'Create', class: 'btn btn-primary'
~~~

Kapchonka will generates a partial '_kapchonka_partial.slim' in 'views/shared/'

~~~ slim
scss:
  .kapchonka {
    width: 30%; min-width: 300px;
  }

.kapchonka
  .kapchonka-image
    img  src="data:image/png;base64,#{image_data}"
  .kapchonka-input.form-group
    input.form-control type="number" name="#{input_name}" placeholder="#{I18n.t 'kapchonka.placeholder'}" required="required"
  .kapchonka-label
    = I18n.t 'kapchonka.label'
~~~

##### Controller

~~~ ruby
class PostsController < ApplicationController
  include Kapchonka::ControllerHelper
  
  before_action :generate_kapchonka, only: [ :new ]
  before_action :wrong_captcha, only: [ :create ], unless: :kapchonka_valid?
end
~~~

### Redis

Kapchonka also support redis!

Add redis gem to gemfile:

~~~ ruby
  gem 'redis'
~~~

update initilizer:

~~~ ruby
redis = Redis.new host: '127.0.0.1', port: 6379

Kapchonka.setup do |k|
  k.store = :redis
  k.redis = redis
end
~~~

### I18n:
~~~ yaml
en:
  kapchonka:
    placeholder: 'Answer of equation'
    label: 'Solve equation and type answer!'
~~~


### Bug reports

If you discover any bugs, feel free to create an issue on GitHub.


