require 'rails_helper'

RSpec.describe "ingredients/new", type: :view do
  before(:each) do
    assign(:ingredient, Ingredient.new(
      name: "MyString",
      unityMeasure: "MyString",
      quantityStock: "9.99"
    ))
  end

  it "renders new ingredient form" do
    render

    assert_select "form[action=?][method=?]", ingredients_path, "post" do
      assert_select "input[name=?]", "ingredient[name]"

      assert_select "input[name=?]", "ingredient[unityMeasure]"

      assert_select "input[name=?]", "ingredient[quantityStock]"
    end
  end
end
