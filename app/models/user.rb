class User < ApplicationRecord
    has_many :user_galleries, dependent: :destroy
end
