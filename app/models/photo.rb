class Photo < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :gallery

    def full_path
        "/uploads/" + self.gallery.id.to_s + '/' + self.url
    end

    def full_url
        domain = 'localhost:3000'
        "http://" + domain + self.full_path
    end
end
