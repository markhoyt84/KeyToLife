class WelcomeController < ApplicationController
  def index
  end

  def search
    @search = Product.new
  end
end
