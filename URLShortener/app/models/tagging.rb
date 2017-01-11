# == Schema Information
#
# Table name: taggings
#
#  id           :integer          not null, primary key
#  tag_id       :integer          not null
#  short_url_id :integer          not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Tagging < ActiveRecord::Base

  belongs_to :tag,
    class_name: 'Tag',
    primary_key: :id,
    foreign_key: :tag_id

  belongs_to :shortened_url,
    class_name: 'ShortenedUrl',
    primary_key: :id,
    foreign_key: :short_url_id



  validates :tag_id, :presence => true
  validates :short_url_id, :presence => true

  def self.record_tag!(tag, shortened_url)
    self.create!(tag_id: tag.id, short_url_id: shortened_url.id)
  end



end
