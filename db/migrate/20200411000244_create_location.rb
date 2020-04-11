class CreateLocation < ActiveRecord::Migration[6.0]
  def change
    create_table :locations do |t|
      t.string :lat
      t.string :lng
      t.string :created_at
      t.string :updated_at
    end
  end
end
