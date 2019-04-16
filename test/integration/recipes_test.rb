require 'test_helper'

class RecipesTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
    def setup
      @chef = Chef.create!(chefname: "Glory", email: "gloryonnaji@gmail.com")
      @recipe1 = Recipe.create(name: "Abacha", description: "This is how to make Abacha", chef: @chef)
      @recipe2 = @chef.recipes.build(name: "Okpa", description: "This is how to make Okpa")
      @recipe2.save
    end
  
  test "should display recipes index page" do
    get recipes_path
    assert_response :success
  end
  
  test "should get recipes listing" do
    get recipes_path
    assert_template 'recipes/index'
    assert_select 'a[href=?]', recipe_path(@recipe1), text:@recipe1.name
    assert_select 'a[href=?]', recipe_path(@recipe2), text:@recipe2.name
  end
  
  test "should show recipe details" do
    get recipe_path(@recipe1)
    assert_template 'recipes/show'
    assert_match @recipe1.name, response.body
    assert_match @recipe1.description, response.body
    assert_match @chef.chefname, response.body
  end
  
  test "should create new valid recipe" do
    get new_recipe_path
    assert_template 'recipes/new'
    name_of_recipe = "Spaghetti bolanaisse"
    description_of_recipe = "Add spaghetti in water, cook for 30 mins"
    assert_difference 'Recipe.count', 1 do
      post recipes_path, params: {recipe: {name: name_of_recipe, description: description_of_recipe}}
    end
    follow_redirect!
    assert_match name_of_recipe.capitalize, response.body
    assert_match description_of_recipe, response.body
    
  end
  
  test "should reject invalid new recipe submission" do
    get new_recipe_path
    assert_template 'recipes/new'
    assert_no_difference 'Recipe.count' do
      post recipes_path, params: {recipe: {name: " ", description: " "}}
    assert_template 'recipes/new'
    assert_select 'h2.panel-title'
    assert_select 'div.panel-body'
    end
  end
  
end
