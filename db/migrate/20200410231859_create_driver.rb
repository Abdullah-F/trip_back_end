class CreateDriver < ActiveRecord::Migration[6.0]
  def change
    create_table :drivers do |t|
      t.string :name
      t.string :created_at
      t.string :updated_at
    end
  end
end
