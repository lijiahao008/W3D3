# == Schema Information
#
# Table name: tags
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime
#  updated_at :datetime
#

class Tag < ActiveRecord::Base

  has_many :taggings,
    class_name: 'Tagging',
    primary_key: :id,
    foreign_key: :tag_id

  has_many :short_urls,
    through: :taggings,
    source: :shortened_url




  validates :name, :presence => true, :uniqueness => true


  def popular_links
    hash = {}
    self.short_urls
    .joins(:visits)
    .group('shortened_urls.long_url')
    .select('shortened_urls.long_url, COUNT(visits.id) as num_visits')
    .order('num_visits DESC')
    .limit(5)
    .each{ |link| hash[link.long_url] = link.num_visits }
    hash
  end
end
