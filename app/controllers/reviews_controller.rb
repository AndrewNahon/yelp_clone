

class ReviewsController < ApplicationController 
  before_filter :require_user, only: [:create]

  def create 
    @business = Business.find(params[:business_id])
    @review = @business.reviews.new(review_params.merge({ user: current_user }))
    if @review.save
      redirect_to business_path(@business), notice: "Your review has been created."
    else
      @business = Business.find(params[:business_id]) 
      render 'businesses/show'
    end
  end

  private 

  def review_params
    params.require(:review).permit(:rating, :body)
  end
end


