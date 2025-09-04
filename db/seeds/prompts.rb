prompts_data = [
  {
    translations: {
      'en' => 'What\'s one thing you\'re grateful for today?',
      'ja' => '今日感謝していることは何ですか？'
    }
  },
  {
    translations: {
      'en' => 'If you could have dinner with anyone, who would it be and why?',
      'ja' => '誰とでも夕食を共にできるとしたら、誰を選び、その理由は何ですか？'
    }
  },
  {
    translations: {
      'en' => 'What\'s a skill you\'d love to learn this year?',
      'ja' => '今年学びたいスキルは何ですか？'
    }
  },
  {
    translations: {
      'en' => 'Describe your perfect weekend in three words.',
      'ja' => '完璧な週末を3つの言葉で表現してください。'
    }
  },
  {
    translations: {
      'en' => 'What\'s the best piece of advice you\'ve ever received?',
      'ja' => '今まで受けた最高のアドバイスは何ですか？'
    }
  },
  {
    translations: {
      'en' => 'If you could travel anywhere tomorrow, where would you go?',
      'ja' => '明日どこにでも旅行できるとしたら、どこに行きますか？'
    }
  },
  {
    translations: {
      'en' => 'What\'s something that always makes you smile?',
      'ja' => 'いつもあなたを笑顔にするものは何ですか？'
    }
  },
  {
    translations: {
      'en' => 'What\'s your favorite way to spend a rainy day?',
      'ja' => '雨の日の好きな過ごし方は何ですか？'
    }
  },
  {
    translations: {
      'en' => 'If you had a superpower, what would it be?',
      'ja' => '超能力があるとしたら、何の力がほしいですか？'
    }
  },
  {
    translations: {
      'en' => 'What\'s the most beautiful place you\'ve ever seen?',
      'ja' => '今まで見た中で最も美しい場所はどこですか？'
    }
  }
]

prompts_data.each do |prompt_data|
  Prompt.find_or_create_by(translations: prompt_data[:translations])
end

puts "Created #{prompts_data.length} prompts!"