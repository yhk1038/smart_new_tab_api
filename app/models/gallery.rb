class Gallery < ApplicationRecord
    has_many :user_galleries
    has_many :photos
end
