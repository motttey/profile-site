class CreateUserDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :user_details do |t|
      t.string :name
      t.string :username
      t.string :nickname
      t.string :location
      t.string :department
      t.string :school_year
      t.string :other_circle
      t.text :about
      t.text :todo
      t.string :twitter
      t.string :string
      t.string :line
      t.string :facebook
      t.binary :image

      t.timestamps
    end
  end
end
