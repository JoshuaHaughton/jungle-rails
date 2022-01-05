class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["AUTHUSER"], password: ENV["AUTHPASS"]

  def show
  end
  
end
