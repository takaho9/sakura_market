class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  # GET /products
  # GET /products.json
  def index
    @products = Product.default_order
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    @product.image.attach(image_params[:image]) unless image_params[:image].blank?

    respond_to do |format|
      if @product.save
        format.html { redirect_to admins_product_path(@product), notice: "Product was successfully created." }
      else
        p @product
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update
    @product.image.attach(image_params[:image]) unless image_params[:image].blank?

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admins_product_path(@product), notice: "更新しました。" }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.image.destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admins_products_url, notice: "更新しました。" }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :status)
    end

    def image_params
      params.require(:product).permit(:image)
    end
end
