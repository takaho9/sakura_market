class Admins::ProductsController < Admins::ApplicationController
  before_action :set_product, only: [ :show, :edit, :update, :destroy ]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all
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
    @product.image.destroy if image_params[:image].blank?
    @product.build_image(image_params) unless image_params[:image].blank?

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to admins_product_path(@product), notice: "Product was successfully updated." }
        format.json { render :show, status: :ok, location: admins_product_path(@product) }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.image.destroy
    @product.destroy

    respond_to do |format|
      format.html { redirect_to admins_products_url, notice: "Product was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      params.require(:product).permit(:name, :price, :description, :status, :image)
    end
end
