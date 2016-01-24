class Register < ActiveRecord::Base
  validates :value, presence: true, length: {minimum: 2}
  after_create :update_fetch_data

  def recent_comments
    Comment.ransack(content_cont: value).result
  end

  def instagrammers
    instagrammers_hash = {}
    users = recent_comments.map(&:user)
    users.each do |user|
      instagrammers_hash[user.username] = user.comments
                                        .map(&:hashtags)
                                        .flatten.select{|i| i.value.include? value}
                                        .count
    end
    instagrammers_hash.sort_by {|_key, value| value}.reverse.to_h
  end

  private
  def update_fetch_data
    FetchCommentsWorker.perform_async self.id
  end
end
