class RecipesController < ApplicationController
  
  def index
    @recipes = Recipe.paginate(page: params[:page], per_page: 4) #Recipe.all.sort_by{|likes| likes.thumbs_up_total}.reverse
  end

  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def new
    if logged_in?
      @recipe  = Recipe.new
    else
      flash[:danger] = "You must be logged in to create a new recipe"
      redirect_to root_path
    end
  end
  
  def create
    if logged_in?
      @recipe = Recipe.new(recipe_params)
      @recipe.chef = Chef.find(2) # To do later!
      
      if @recipe.save
        flash[:success] = "Your recipe was created successfully!"
        redirect_to recipes_path
      else
        render 'new'
      end
    else
      flash[:danger] = "You must be logged in to create a new recipe"
      redirect_to root_path
    end
  end
  
  def edit
    if !logged_in?
      flash[:danger] = "You must be logged in to edit a recipe"
      redirect_to :back
    else
      @recipe  = Recipe.find(params[:id])
      if @recipe.chef != current_user
        flash[:danger] = "You can only edit your own recipes!"
        redirect_to :back
      else
      end
    end
  end
  
  def update
    @recipe = Recipe.find(params[:id])
    
    if @recipe.update(recipe_params)
      flash[:success] = "Successfully edited " + @recipe.name + "!"
      redirect_to recipe_path(@recipe)
    else
    render 'new'
    end
  end
  
  def like
    @recipe = Recipe.find(params[:id])
    like = Like.create(like: params[:like], chef: Chef.first, recipe: @recipe) # hard code chef until we have users coded
    if like.valid?
      flash[:success] = "Your selection was successful"
      redirect_to :back
    else
      flash[:danger] = "You can only like/dislike a recipe once"
      redirect_to :back
    end
  end
  
  private
    def recipe_params
      params.require(:recipe).permit(:name, :summary, :description, :picture)
    end
  
end