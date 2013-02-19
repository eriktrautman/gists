class Gist < ActiveRecord::Base
  attr_accessible :title, :user_id, :files_attributes, :tag_ids

  belongs_to :author, class_name: "User", foreign_key: :user_id
  has_many :files, class_name: "GistFile", foreign_key: :gist_id, inverse_of: :gist
  has_many :taggings, inverse_of: :gist
  has_many :tags, through: :taggings

  validates :author, :title, presence: true

  accepts_nested_attributes_for :files

  def to_s
    title
  end

  def tag(tag_name)
    tag = Tag.find_or_create_by_name(tag_name)
    taggings.create(tag_id: tag.id).id ? tag : false
  end

  def tag_ids=(ids)
    ids.shift
    ids.each do |id|
      taggings.build(tag_id: id)
    end
  end
end
