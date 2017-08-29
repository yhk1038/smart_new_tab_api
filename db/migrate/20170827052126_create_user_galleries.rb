class CreateUserGalleries < ActiveRecord::Migration[5.1]
  def change
    create_table :user_galleries do |t|
      t.references :user, foreign_key: true
      t.references :gallery, foreign_key: true

      t.timestamps
    end
  end
end
