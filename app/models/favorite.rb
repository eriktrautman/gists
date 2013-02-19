class Favorite < ActiveRecord::Base
  attr_accessible :gist_id, :user_id

  belongs_to :user
  belongs_to :gist

  validates :user, :gist, presence: true
  validates :gist_id, uniqueness: { scope: :user_id }
end
