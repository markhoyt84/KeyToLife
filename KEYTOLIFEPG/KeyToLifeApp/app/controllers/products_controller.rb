class ProductsController < ApplicationController

  def get_cart
    if session[:current_cart] == nil
      @current_cart = ShoppingCart.new
    else
      @current_cart = ShoppingCart.find(session[:current_cart])
    end
  end


  # GET /products
  # GET /products.json
  def index
    @products = Product.all
  end

  # GET /products/1
  # GET /products/1.json
  def show
    get_cart
    @categories = Category.all
    @product = Product.find(params[:id])
    @category = @product.category
    @currentProduct = @product
    array = [1, 2, 3, 4]
    if array.include?(@category.id)
      @related = []
      @related = @product.get_related
    end
    if @product.name == 'Growers Magic'
      @name = "Grower's Magic"
    end
    @description = @product.description
    @products = Product.where("name = '#{@product.name}'")
  end

  # # GET /products/new
  # def new
  #   @product = Product.new
  # end

  # # GET /products/1/edit
  # def edit
  # end

  # POST /products
  # POST /products.json
  # def create
  #   @product = Product.new(product_params)

  #   respond_to do |format|
  #     if @product.save
  #       format.html { redirect_to @product, notice: 'Product was successfully created.' }
  #       format.json { render :show, status: :created, location: @product }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /products/1
  # # PATCH/PUT /products/1.json
  # def update
  #   respond_to do |format|
  #     if @product.update(product_params)
  #       format.html { redirect_to @product, notice: 'Product was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @product }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @product.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # DELETE /products/1
  # # DELETE /products/1.json
  # def destroy
  #   @product.destroy
  #   respond_to do |format|
  #     format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
  #     format.json { head :no_content }
  #   end
  # end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def product_params
      params[:product]
    end
end
