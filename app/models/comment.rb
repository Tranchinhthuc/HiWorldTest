class Comment < ActiveRecord::Base
  belongs_to :user
  has_many :hashtags
  
  after_create :save_hashtags

  def find_hashtags
    content.split(" ").select{|word| word[0]=="#" && word[1]!="#"}
  end

  private
  def save_hashtags
    find_hashtags.each do |hashtag|
      self.hashtags.create(value: hashtag) unless self.hashtags.map(&:value).include? hashtag
    end
  end
end
