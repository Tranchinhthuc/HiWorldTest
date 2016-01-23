namespace :db do
  desc "Remaking data"
  task remake_data: :environment do

    puts "Reset"
    Rake::Task["db:migrate:reset"].invoke

    puts "Creats users"
    10.times{|i|
      User.create username: "username#{i}", avatar: "images/images.jpeg"
    }

    puts "Create sample hashtag values"
    HASHTAGS_ARRAY = []
    30.times {|i|
      HASHTAGS_ARRAY<< "##{Faker::Lorem.word}"
    }

    puts "Creats comments"
    User.all.each do |user|
      rand(5..15).times{
        hashtags = HASHTAGS_ARRAY.sample rand(1..5)
        user.comments.create content:("#{Faker::Lorem.sentence} #{hashtags.join(", ")}")
      }
    end
  end
end
