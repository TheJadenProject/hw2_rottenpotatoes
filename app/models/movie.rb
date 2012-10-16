class Movie < ActiveRecord::Base
def self.all_ratings
	ratings = []
	self.select(:rating).order(:rating).each do |rating|
		ratings << rating.rating
	end
	ratings.uniq
end

def self.all_by_rating(rating, order)
	if (order != nil)
		self.where(:rating => rating).order(order)
	else
		self.where(:rating => rating)
	end
end
end
