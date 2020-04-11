class Trip < ApplicationRecord
  has_many :drivers, dependent: :nullify
  has_many :locations, dependent: :destroy

  enum status: { ongoing: 0, completed: 1 }
end
