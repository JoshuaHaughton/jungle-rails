class ProductsController < ApplicationController
  
  http_basic_authenticate_with name: ENV["AUTHUSER"], password: ENV["AUTHPASS"]
  #  if: -> { ENV['RAILS_ENV'] == 'production' }
  
  def index
    @products = Product.all.order(created_at: :desc)
  end

  def show
    @product = Product.find params[:id]
  end

end
