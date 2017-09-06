class AddWhiteListToGallery < ActiveRecord::Migration[5.1]
    def change
        add_column :galleries, :white_list, :string
    end
end
