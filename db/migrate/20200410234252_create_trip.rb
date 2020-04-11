class CreateTrip < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.integer :status
      t.string :created_at
      t.string :updated_at
    end
  end
end
