class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, presence: true, uniqueness: true

  has_many :taggings
  has_many :gists, through: :gists
end
