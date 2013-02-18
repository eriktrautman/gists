class GistFile < ActiveRecord::Base
  attr_accessible :body, :gist_id

  belongs_to :gist, inverse_of: :files

  validates :gist, :body, presence: true
end
