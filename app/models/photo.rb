class Photo < ApplicationRecord
    mount_uploader :image, ImageUploader
    belongs_to :gallery

    def full_path
        "/uploads/" + self.gallery.id.to_s + '/' + self.url
    end

    def full_url
        domain = '52.79.83.67'
        "http://" + domain + self.full_path
    end

    def author
        User.find(self.author_id)
    end
end
