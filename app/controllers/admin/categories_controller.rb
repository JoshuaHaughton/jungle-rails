class Admin::CategoriesController < ApplicationController

  http_basic_authenticate_with name: ENV["AUTHUSER"], password: ENV["AUTHPASS"]

  def index
    @categories = Category.order(id: :desc).all
    @products_length = Product.order(id: :desc).all
    puts Product.order(id: :desc).all.select { |n| n.category_id == 1 }
  end

  def new
    @category = Category.new
  end

  def unique_products_by_id(id)
    list = Product.order(id: :desc).all.select { |n| n.category_id == id }.length
    list
  end

  def create
    @category = Category.new(category_params)

    if @category.save
      redirect_to [:admin, :categories], notice: 'Category created!'
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit(
      :name
    )
  end

end
