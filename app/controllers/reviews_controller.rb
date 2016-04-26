class ReviewsController < ApplicationController
  
  before_action :set_recipe, only: [:edit, :update, :show, :index]
  before_action :require_user, except: [:show, :index]
  
  def new
    @review = Review.new
  end
  
  def index
    @reviews = Review.where(:recipe_id => @recipe.id).paginate(page: params[:page], per_page: 4)
  end

  
  def create
      @recipe =    
      @review = Review.new(review_params)
      @review.chef = current_user
      @review.recipe = 
      
      if @review.save
        flash[:success] = "Your review was posted successfully!"
        redirect_to recipe_path(@recipe)
      else
        render 'new'
      end
  end
  
  def edit
      
  end
  
  def show
    @review = Review.find_by(recipe_id: @recipe.id)
  end
  
  private
  
    def review_params
      params.require(:review).permit(:body)
    end
  
    def set_recipe
      @recipe = Recipe.find(params[:recipe_id])
    end
  
  
end