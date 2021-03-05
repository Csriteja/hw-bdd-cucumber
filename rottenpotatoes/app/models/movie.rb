class Movie < ActiveRecord::Base
  def self.all_ratings
        self.pluck(:rating).uniq
    end
    
    def self.get_ratings(ratings_list)
        if ratings_list.present?
            self.where(:rating => ratings_list)
        end
    end
    
    def self.get_sorted_ratings(ratings_list, sort_by)
        if ratings_list.present? && sort_by.present?
            self.where(:rating => ratings_list).order(sort_by)
        end
    end
end
