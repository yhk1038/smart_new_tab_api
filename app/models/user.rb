class User < ApplicationRecord
    has_many :user_galleries, dependent: :destroy
    has_many :galleries, through: :user_galleries
end
