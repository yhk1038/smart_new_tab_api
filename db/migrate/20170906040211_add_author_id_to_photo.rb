class AddAuthorIdToPhoto < ActiveRecord::Migration[5.1]
  def change
    add_column :photos, :author_id, :integer
  end
end
