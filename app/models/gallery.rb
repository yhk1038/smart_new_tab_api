class Gallery < ApplicationRecord
    has_many :user_galleries, dependent: :destroy
    has_many :users, through: :user_galleries
    has_many :photos, dependent: :destroy

    def photos_url
        self.photos.map{|s| s.image.url}
    end
end
