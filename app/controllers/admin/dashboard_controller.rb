class Admin::DashboardController < ApplicationController

  http_basic_authenticate_with name: ENV["AUTHUSER"], password: ENV["AUTHPASS"]

  def show
    @products = Product.order(id: :desc).all
    @products_length = @products.length
    @categories = Category.all
    @categories_length = @categories.length
    puts Category.all[0].methods
  end
  
end
