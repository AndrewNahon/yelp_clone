class BusinessesController < ApplicationController
  before_filter :require_user, only: [:new, :create]
  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find(params[:id])
    @review = Review.new
  end

  def new
    @business = Business.new 
  end

  def create
    @business = Business.new(business_params)

    if @business.save 
      redirect_to business_path(@business)
      flash[:notice] = "The business was successfully registered."
    else
      render :new
    end
  end

  private 

  def business_params
    params.require(:business).permit(:name, :description, :city)
  end
end