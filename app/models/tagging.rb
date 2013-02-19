class Tagging < ActiveRecord::Base
  attr_accessible :gist_id, :tag_id

  belongs_to :gist, inverse_of: :taggings
  belongs_to :tag

  validates :gist_id, uniqueness: { scope: :tag_id }
end
