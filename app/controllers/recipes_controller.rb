class RecipesController < ApplicationController
before_action :authorization_status

def index
recipe = Recipe.all
render json: recipe
end

def create
user ||= User.find_by(id: session[:user_id])
if user
    recipe = user.recipes.create!(recipe_params)
    render json: recipe, status: :created
else
    render json: { errors: "Not authorized"}, status: :unauthorized
end
end



private 

def recipe_params
    params.permit(:title,:instructions,:minutes_to_complete)
end



end


# user ||= User.find_by(username: params[:username])
# if user = session[:user_id]

  
#   session[:user_id] = recipe.id
# render json: recipe, status: :created
# else
#     render json: { errors: ["Not authorized"]}, status: :unauthorized
#     end
