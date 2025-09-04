require 'json' 
file_path = Rails.root.join("db/seeds/daily_prompts.json")
json = JSON.parse(File.read(file_path))

json["prompts"].each do |p|
  translations = p["translations"]
  DailyPrompt.create(
    en: translations["en"],
    ja: translations["ja"]
  )
end