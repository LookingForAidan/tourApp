class Tourtwo < ActiveRecord::Base
    def self.search(search)
        where("lname LIKE ?", "%#{search}%")
    end
end
