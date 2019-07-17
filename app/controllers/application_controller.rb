class ApplicationController < Sinatra::Base
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
  end


  get "/" do
    redirect to "/recipes"
  end

  get "/recipes" do
    @recipe = Recipe.all
    erb :index
  end

  # Create a route to create a new article.
  get "/recipes/new" do
    @recipe = Recipe.new
    erb :new
  end

  post "/recipes/?" do
    @recipe = Recipe.create(params)
    redirect to "/recipes/#{@recipe.id}"
  end

  # Save it search by ID.
patch "/recipes/:id" do
  @recipe = Recipe.find(params[:id])
  @recipe.name = params[:name]
  @recipe.ingredients = params[:ingredients]
  @recipe.cook_time = params[:cook_time]
  @recipe.save
  redirect to "/recipes/#{@recipe.id}"
end


  get "/recipes/:id/edit" do
    id = params[:id]
    @recipe = Recipe.find(id)
    erb :edit
  end


  get "/recipes/:id" do
  @recipe = Recipe.find(params[:id])
  erb :show
end

delete "/recipes/:id" do
  Recipe.destroy(params[:id])
  redirect to "/recipes"
end


end
