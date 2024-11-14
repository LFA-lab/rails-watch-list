# app/controllers/reviews_controller.rb

class ReviewsController < ApplicationController
  def create
    @list = List.find(params[:list_id])
    @review = @list.reviews.build(review_params)
    if @review.save
      respond_to do |format|
        format.html { redirect_to list_path(@list), notice: "Review added successfully." }
        format.js  # Cela renverra create.js.erb si vous utilisez AJAX
      end
    else
      render "lists/show", status: :unprocessable_entity
    end
  end

  private

  def review_params
    params.require(:review).permit(:content, :rating)
  end
end
