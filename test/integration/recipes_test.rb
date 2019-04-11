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
    assert_match @recipe1.name, response.body
    assert_match @recipe2.name, response.body
  end
  
end
