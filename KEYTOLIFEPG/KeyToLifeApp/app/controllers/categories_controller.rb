class CategoriesController < ApplicationController

  def index
    categories = Category.all
    @categories = categories.each_slice(3).to_a
  end

  def show
    category = Category.find(params[:id])
    if category.id == 1
      @products = category.products.where('size' => '2 oz.')
    elsif category.id == 2
      @products = category.products.where('size' => '2 oz.')
    end
  end
end
