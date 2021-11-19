class Chat < ApplicationRecord
  belongs_to :application
  has_many :messages

  validates :sequential_number, presence: true
  validates :sequential_number, uniqueness: {scope: :application}
end
