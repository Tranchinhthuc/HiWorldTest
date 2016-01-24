class FetchCommentsWorker
  include Sidekiq::Worker
  sidekiq_options retry: 5

  def perform register_id
    register = Register.find register_id
    recent_comments = register.recent_comments
    amount = recent_comments.count
    instagrammers = register.instagrammers
    fetch_data = {recent_comments: eval(recent_comments.to_json), amount: amount, instagrammers: instagrammers}
    register.update_attributes fetch_data: fetch_data.to_s
  end
end
