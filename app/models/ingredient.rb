class Ingredient < ActiveRecord::Base
	has_many :recipe_ingredients
	has_many :recipes, through: :recipe_ingredients

	def self.tokens(query)
		ingredients = where("name like ?", "%#{query}%")
		if ingredients.empty?
			[{id: "<<<#{query}>>>", name: "New: \"#{query}\""}]
		else
			ingredients
		end
	end

	def self.ids_from_tokens(tokens)
		tokens.gsub!(/<<<(.+?)>>>/) { create!(name: $1).id }
		tokens.split(',')
	end
	
	def self.search(search)
		if search
			find(:all, :conditions => ['name LIKE ? or description LIKE ?', "%#{search}%", "%#{search}%"])
		else
			find(:all)
		end
	end
end
