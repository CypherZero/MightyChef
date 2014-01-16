class Recipe < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :ingredients, through: :recipe_ingredients

	accepts_nested_attributes_for :recipe_ingredients
	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%"])
		else
			find(:all)
		end
	end
end 