class AboutController < ApplicationController

  def index
    @product_list_length = Product.all.length
    @random_product_length = 1 + rand(@product_list_length)
    @random_product = Product.all[@random_product_length]
    puts Product.all[0].methods
  end

end
