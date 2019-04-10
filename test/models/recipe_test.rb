require "test_helper"

class RecipeTest < ActiveSupport::TestCase

  def setup
    @chef = Chef.create!(chefname: "Glory", email: "gloryonnaji@gmail.com")
    @recipe = Recipe.new(name: "Abacha", description: "This is a recipe on how to make Abacha", chef_id: @chef.id)
  end
  
  test "recipe must be valid" do
    assert @recipe.valid?
  end
  
  test "recipe without chef should be invalid" do
    @recipe.chef_id = nil
   assert_not @recipe.valid?
  end 
  
  
  test "name must be present" do
    @recipe.name = ""
    assert_not @recipe.valid?
  end
  
  test "description must be present" do
    @recipe.description = ""
    assert_not @recipe.valid?
  end
  
  test "description must not be less than 5 characters" do
    @recipe.description = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "description must not be more than 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

end