class Register < ActiveRecord::Base
  validates :value, presence: true, length: {minimum: 3}

  def count
    Comment.ransack(content_cont: value).result.count
  end

  def recent_comments
    Comment.ransack(content_cont: value).result.order(created_at: :desc)
  end

  def instagrammers
    instagrammers_hash = {}
    users = Comment.ransack(content_cont: value).result.map(&:user)
    users.each do |user|
      instagrammers_hash[user.username] = user.comments
                                        .map(&:hashtags)
                                        .flatten.select{|i| i.value.include? value}
                                        .count
    end
    instagrammers_hash.sort_by {|_key, value| value}.reverse.to_h
  end
end
