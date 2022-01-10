require 'rails_helper'

RSpec.describe Product, type: :model do
  describe 'Validations' do

    it "is valid" do
      @product = Product.new
      @category = Category.new

      @category.name = 'name'
      @product.name = 'name'
      @product.price_cents = 24643
      @product.quantity = 5
      @product.category = @category
      expect(@product.valid?).to be true
    end

    it "name prsent?" do
      @product = Product.new
      @product.name = nil
      @product.valid?
      expect(@product.errors[:name]).to  include("can't be blank")
  
      @product.name = 'name'
      @product.valid? 
      expect(@product.errors[:name]).not_to  include("can't be blank")
    end

    it "price_cents present?" do
      @product = Product.new
      @product.price_cents = nil
      @product.valid?

      expect(@product.errors[:price_cents]).to  include("is not a number")
  
      @product.price_cents = 432345
      @product.valid? 

      expect(@product.errors[:price_cents]).not_to  include("can't be blank")
    end
  
    it "quantity" do
      @product = Product.new
      @product.quantity = nil
      @product.valid?
      expect(@product.errors[:quantity]).to  include("can't be blank")
  
      @product.quantity = 1
      @product.valid? 
      expect(@product.errors[:quantity]).not_to  include("can't be blank")
    end
  
    it "has category_id" do
      @category = Category.new
      @product = Product.new
      @product.category = nil
      @product.valid?
      expect(@product.errors[:category]).to  include("can't be blank")

      @product.category = @category
      @product.valid? 
      expect(@product.errors[:category]).not_to  include("can't be blank")
    end


  end
end
