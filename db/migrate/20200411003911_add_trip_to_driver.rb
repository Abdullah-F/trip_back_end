class AddTripToDriver < ActiveRecord::Migration[6.0]
  def change
    add_reference :drivers, :trip, foreign_key: true
  end
end
