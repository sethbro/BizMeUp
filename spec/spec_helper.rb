ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require 'rubygems'
gem 'minitest'
require 'minitest/autorun'
require 'minitest/context'
require 'miniskirt'
require 'action_controller/test_case'

require 'capybara/rails'
require 'awesome_print'
require 'mocha'
require 'turn'

# Support files
Dir["#{File.expand_path(File.dirname(__FILE__))}/support/*.rb"].each do |file|
  require file
end


class MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown

  alias :method_name :__name__ if defined? :__name__
end


class ControllerSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include ActionController::TestCase::Behavior

  before do
    @routes = Rails.application.routes
  end
end

# Test subjects ending with 'Controller' are treated as functional tests
#   e.g. describe TestController do ...
MiniTest::Spec.register_spec_type( /Controller$/, ControllerSpec )


class AcceptanceSpec < MiniTest::Spec
  include Rails.application.routes.url_helpers
  include Capybara::DSL
  #include CommonActions

  before do
    @routes = Rails.application.routes
  end
end

# Test subjects ending with 'Integration' are treated as acceptance/integration tests
#   e.g. describe 'Test system Integration' do ...
MiniTest::Spec.register_spec_type( /Integration$/, AcceptanceSpec )


Turn.config do |c|
  # use one of output formats:
  # :outline  - turn's original case/test outline mode [default]
  # :progress - indicates progress with progress bar
  # :dotted   - test/unit's traditional dot-progress mode
  # :pretty   - new pretty reporter
  # :marshal  - dump output as YAML (normal run mode only)
  # :cue      - interactive testing
  c.format  = :cue
  # turn on invoke/execute tracing, enable full backtrace
  c.trace   = true
  # use humanized test names (works only with :outline format)
  c.natural = true
end
