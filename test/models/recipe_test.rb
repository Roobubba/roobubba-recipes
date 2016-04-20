require 'test_helper'

class RecipeTest < ActiveSupport::TestCase
  
  def setup
    @chef = Chef.create(chefname: "bill", email: "bob@example.com")
    @recipe = @chef.recipes.build( name: "Chicken Soup", summary: "The Best Chicken Soup Ever",
              description: "Take 1kg Chicken, brown, remove. Cook onion and garlic. Add stock, chicken, blitz and eat")
  end
  
  test "Recipe should be valid" do
    assert @recipe.valid?
  end
  
  test "Chef_ID should be present" do
    @recipe.chef_id = nil
    assert_not @recipe.valid?
  end
  
  
  test "Name should be present" do
    @recipe.name = " "
    assert_not @recipe.valid?
  end
  
  test "Name must be >= 5 characters" do
    @recipe.name = "a" * 4
    assert_not @recipe.valid?
  end
  
  test "Name must be <= 100 characters" do
    @recipe.name = "a" * 101
    assert_not @recipe.valid?
  end
  
  test "Summary should be present" do
    @recipe.summary = " "
    assert_not @recipe.valid?
  end
  
  test "Summary must be >= 10 characters" do
    @recipe.summary = "a" * 9
    assert_not @recipe.valid?
  end
  
  test "Summary must be <= 150 characters" do
    @recipe.summary = "a" * 151
    assert_not @recipe.valid?
  end
    test "Description should be present" do
    @recipe.description = " "
    assert_not @recipe.valid?
  end
  
  test "Description must be >= 20 characters" do
    @recipe.description = "a" * 19
    assert_not @recipe.valid?
  end
  
  test "Description must be <= 500 characters" do
    @recipe.description = "a" * 501
    assert_not @recipe.valid?
  end

end