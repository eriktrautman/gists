class User < ActiveRecord::Base
  attr_accessible :user_name

  before_save :set_remember_token

  has_many :gists
  has_many :favorites
  has_many :favorite_gists, through: :favorites, source: :gist

  validates :user_name, presence: true, uniqueness: true, length: { minimum: 5 }

  def to_s
    user_name
  end

  def favorite_gist(gist_id)
    Favorite.create(user_id: self.id, gist_id: gist_id)
  end

  def unfavorite_gist(gist_id)
    fav = Favorite.where(user_id: self.id, gist_id: gist_id).first
    fav.destroy if fav
  end

  def favorited?(gist)
    self.favorite_gists.include?(gist)
  end

  private

  def set_remember_token
    self.remember_token = SecureRandom.urlsafe_base64
  end
end
