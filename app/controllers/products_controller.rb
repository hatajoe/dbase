class ProductsController < ApplicationController
  include UserAuthenticatable
  include OrganizationAuthenticatable
  include ProductSessionable
  include GithubAccessible

  before_action :user_authenticate
  before_action :organization_authenticate
  before_action :set_product, only: [:show, :update, :destroy]

  # GET /products
  # GET /products.json
  def index
    @products = Product.all_by_organization(@current_organization)
  end

  # GET /products/1
  # GET /products/1.json
  def show
    store_product_id(@product)
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)
    repository = Repository.find_by(full_name: product_params[:repository_name])
    build_repository_tree(repository)
    create_hook(@current_organization.github_api_token, repository, Rails.application.secrets.github_webhook_encryption_key)

    respond_to do |format|
      if @product.save && repository.save
        format.html { redirect_to @product, notice: 'Product was successfully created.' }
        format.json { render :show, status: :created, location: @product }
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /organizations/1
  # PATCH/PUT /organizations/1.json
  def update
    @product.repository.milestones.destroy_all
    @product.repository.projects.destroy_all
    build_repository_tree(@product.repository)
    respond_to do |format|
      if @product.repository.save
        format.html { redirect_to @product, notice: 'Product was successfully updated.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.repository.milestones.destroy_all
    @product.repository.projects.destroy_all
    @product.destroy
    delete_hook(@current_organization.github_api_token, @product.repository)

    respond_to do |format|
      format.html { redirect_to products_url, notice: 'Product was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_product
    @product = Product.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def product_params
    params.require(:product).permit(:repository_name, :name).merge(organization_id: @current_organization.id)
  end

  #
  # @param [Repository] repository
  #
  def build_repository_tree(repository)
    milestones(@current_organization.github_api_token, repository, options: { state: :open }).each do |milestone|
      issues(@current_organization.github_api_token, milestone)
    end
    projects(@current_organization.github_api_token, repository)
    repository.projects.each { |p| project_columns(@current_organization.github_api_token, p) }
    repository.projects.each { |p| p.project_columns.each { |pc| project_cards(@current_organization.github_api_token, pc) } }
  end
end
