require 'authlogic/test_case'
include Authlogic::TestCase

class DashboardsController < ApplicationController
  before_filter :activate_authlogic
  def index
  end
end
