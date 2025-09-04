# メインのサンプルユーザーを1人作成する
User.create!(name:  "Example User",
  email: "example@railstutorial.org",
  password:              "foobar",
  password_confirmation: "foobar",
  admin:     true,
  activated: true,
  activated_at: Time.zone.now)

# 追加のユーザーをまとめて生成する
99.times do |n|
name  = Faker::Name.name
email = "example-#{n+1}@railstutorial.org"
password = "password"
User.create!(name:  name,
    email: email,
    password:              password,
    password_confirmation: password,
    activated: true,
    activated_at: Time.zone.now)
end

# ユーザーの一部を対象にマイクロポストを生成する
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(word_count: 5)
  users.each { |user| user.microposts.create!(content: content) }
end

# ユーザーフォローのリレーションシップを作成する
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

load File.join(Rails.root, 'db', 'seeds', 'prompts.rb')

# Clear existing prompts first
Prompt.destroy_all

# Load prompts from JSON file
prompts_file = Rails.root.join('db', 'data', 'prompts.json')
if File.exist?(prompts_file)
  json_data = JSON.parse(File.read(prompts_file))
  
  json_data['prompts'].each do |prompt_data|
    Prompt.create!(translations: prompt_data['translations'])
  end
  
  puts "Created #{json_data['prompts'].length} prompts from JSON file!"
else
  puts "JSON file not found at #{prompts_file}"
end
