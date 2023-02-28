class RecipesController < ApplicationController

  def index
    render json: Recipe.all
  end

  def create
    recipe = user.recipes.create!(recipe_params)
      if user.valid?
        session[:user_id] = user.id
        render json: recipe, status: :created
      else
        render json: { errors: recipe.errors.full_messages }, status: :unprocessable_entity
      end
  end

  private

  def user
    user = User.find_by(id: session[:user_id])
  end

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
end
