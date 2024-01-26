# spec/models/step_spec.rb

RSpec.describe Step, type: :model do
    describe "associations" do
      it "belongs to a recipe" do
        association = described_class.reflect_on_association(:recipe)
        expect(association.macro).to eq(:belongs_to)
      end
    end
  
    describe "validations" do
      it "is valid with a description" do
        recipe = Recipe.create
        step = Step.new(description: "Step 1", recipe: recipe)
        expect(step).to be_valid
      end
    end
  end