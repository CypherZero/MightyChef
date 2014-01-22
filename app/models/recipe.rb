class Recipe < ActiveRecord::Base
	# attr_accessible :name, :description, :ingredient_tokens

	has_many :recipe_ingredients
	has_many :ingredients, through: :recipe_ingredients
	attr_reader :ingredient_tokens
	accepts_nested_attributes_for :recipe_ingredients 

	def ingredient_tokens=(tokens)
		self.ingredient_ids = Ingredient.ids_from_tokens(tokens)
	end
	
	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%"])
		else
			find(:all)
		end
	end
end 