module ApplicationHelper
  def instagrammer user_id
    User.find(user_id).username
  end
end
