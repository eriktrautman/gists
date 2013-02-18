class Gist < ActiveRecord::Base
  attr_accessible :title, :user_id

  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :files, class_name: "GistFile", foreign_key: :gist_id, inverse_of: :gist

  validates :author, :title, presence: true

  def to_s
    title
  end
end
