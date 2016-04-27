class ReviewsController < ApplicationController
  
  before_action :set_recipe
  before_action :require_user, except: [:show, :index]
  before_action :require_same_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy
  
  def index
    @reviews = Review.where(:recipe_id => params[:recipe_id]).paginate(page: params[:page], per_page: 3)
  end
  
  def new
    @review = Review.new
  end
  
  def create
    @review = Review.new(review_params)
    @review.chef = current_user
    @review.recipe = @recipe
    
    if @review.save
      flash[:success] = "Your review was posted successfully!"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def edit
    #@review = Review.where(recipe_id: @recipe.id, chef_id: current_user.id)
  end
  
  def update
    if @review.update(review_params)
      flash[:success] = "Successfully edited the review"
      redirect_to recipe_path(@recipe)
    else
      render 'new'
    end
  end
  
  def show
    @review = Review.find_by(recipe_id: @recipe.id)
  end
  
  def destroy
    Review.find(params[:id]).destroy
    flash[:success] = "Review Deleted"
    redirect_to recipe_path(id: @recipe.id)
  end
  
  private
  
    def review_params
      params.require(:review).permit(:body)
    end
  
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end
  
    def require_same_user
      @review = Review.find(params[:id])
      if current_user != @review.chef and !current_user.admin?
        flash[:danger] = "You can only edit your own reviews"
        redirect_to recipe_path(@recipe)
      end
    end
    
    def admin_user
      redirect_to recipes_path unless current_user.admin?
    end
end