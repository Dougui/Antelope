#encoding=utf-8
require 'rubygems'
require 'spork'


Spork.prefork do
  
end

Spork.each_run do
  load "#{Rails.root}/config/routes.rb"
  Dir["#{Rails.root}/factories/**.rb"].each { |f| load f }
  Dir["#{Rails.root}/app/**/*.rb"].each { |f| load f }
  I18n.backend.load_translations
end