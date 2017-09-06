class Gallery < ApplicationRecord
    has_many :user_galleries, dependent: :destroy
    has_many :users, through: :user_galleries
    has_many :photos, dependent: :destroy

    SUPER_ADMIN_EMAILS = %w(yhk1038@hanmail.net yhkks1038@gmail.com)
    def readable? user_id
        state = true
        user = User.find(user_id)

        # 최고 관리자인 경우 모든 갤러리에 읽기 권한 부여
        return true if SUPER_ADMIN_EMAILS.include? user.email

        if self.white_list
            list = self.white_list.gsub(' ','').split(',')

            unless list.include? user.email
                state = false
            end
        end
        state
    end

    def photos_url
        self.photos.map{|s| s.image.url}
    end
end
