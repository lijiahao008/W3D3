# == Schema Information
#
# Table name: visits
#
#  id           :integer          not null, primary key
#  user_id      :integer
#  short_url_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#

class Visit < ActiveRecord::Base
  validates :short_url_id, :presence => true
  validates :user_id, :presence => true

  belongs_to :user_visits,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  belongs_to :url_visits,
      class_name: 'ShortenedUrl',
      primary_key: :id,
      foreign_key: :short_url_id




  def self.record_visit!(user, shortened_url)
    self.create!(user_id: user.id, short_url_id: shortened_url.id)
  end

end
