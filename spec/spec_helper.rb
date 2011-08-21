#encoding=utf-8
require 'rubygems'
require 'spork'


Spork.prefork do
  if ENV["RUBYMINE_HOME"]
    $:.unshift(File.expand_path("rb/testing/patch/common", ENV["RUBYMINE_HOME"]))
    $:.unshift(File.expand_path("rb/testing/patch/bdd", ENV["RUBYMINE_HOME"]))
  end
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'

  Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

  ENV['AUTOFEATURE'] = "true"
  ENV['RSPEC'] = "true"

  RSpec.configure do |config|
    config.mock_with :rspec
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.use_transactional_fixtures = true

    include ApplicationHelper
    config.include(ApplicationHelper)

    # Needed for Spork
    ActiveSupport::Dependencies.clear

    require "authlogic/test_case"
    include Authlogic::TestCase


    require 'capybara/rspec'
    include Capybara::DSL
  end
end

Spork.each_run do
  I18n.locale = 'fr'

  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/factories/**.rb"].each { |f| load f }
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  I18n.backend.load_translations
end