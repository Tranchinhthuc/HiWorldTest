namespace :db do
  desc "Remaking data"
  task remake_data: :environment do

    puts "Reset"
    Rake::Task["db:migrate:reset"].invoke

    puts "Creats users"
    10000.times{|i|
      User.create username: "username#{i}", email: "thuc#{i}@gmail.com", password: "12341234"
    }

    puts "Create sample hashtag values"
    HASHTAGS_ARRAY = []
    30000.times {|i|
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
