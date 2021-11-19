class Application < ApplicationRecord
  has_secure_token :token
  has_many :chats

  validates :name, presence: true
  validates :token, uniqueness: true
end
