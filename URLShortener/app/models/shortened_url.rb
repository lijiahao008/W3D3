# == Schema Information
#
# Table name: shortened_urls
#
#  id         :integer          not null, primary key
#  long_url   :string
#  short_url  :string
#  user_id    :integer
#  created_at :datetime
#  updated_at :datetime
#

class ShortenedUrl < ActiveRecord::Base


  validates :long_url, :presence => true
  validates :short_url, :presence => true, :uniqueness => true
  validates :user_id, :presence => true

  belongs_to :submitter,
    class_name: 'User',
    primary_key: :id,
    foreign_key: :user_id

  has_many :visits,
    class_name: 'Visit',
    primary_key: :id,
    foreign_key: :short_url_id

  has_many :visitors,
    Proc.new { distinct },
    class_name: 'User',
    through: :visits,
    source: :user_visits

  has_many :taggings,
    class_name: 'Tagging',
    primary_key: :id,
    foreign_key: :short_url_id

  has_many :tags,
    through: :taggings,
    source: :tag




  def self.random_code
    string = SecureRandom::urlsafe_base64(16)
    until self.find_by(short_url: string).nil?
      string = SecureRandom::urlsafe_base64(16)
    end
    string
  end

  def self.create_for_user_and_long_url!(user, long_url)
    self.create!(
      long_url: long_url,
      short_url: self.random_code,
      user_id: user.id
    )
  end

  def num_clicks
    Visit.select(:user_id).where("short_url_id = #{id}").count
  end

  def num_uniques
    visitors.count
    # Visit.select(:user_id).where("short_url_id = #{id}").distinct.count
  end

  def num_recent_uniques
    Visit.select(:user_id)
    .where("short_url_id = #{id} AND visits.created_at > ?", 10.minutes.ago)
    .distinct.count
  end

end
