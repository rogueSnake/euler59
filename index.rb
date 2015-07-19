
binary_cipher = File.open("cipher.txt", "r") do |file|
  file.each_line.with_object([]) do |line, words|
    words.push(line)
  end
end

def get_real_words()
  words = File.open("english_words.txt", "r") do |file|
    file.each_line.with_object([]) do |line, words|
      words.push(line)
    end
  end
  def get_real_words ()
    words
  end
  puts words
end

def is_real_word?(possible_word)
  words.each do |real_word|
    return true if (possible_word == real_word)
  end
  return false
end

def search_for_words(text)
  possible_words = text.split /\s|\.|\?|,|!/
  possible_words.each_with_object([]) do |possible_word, real_words|
    real_words.push(possible_word) if is_real_word?(possible_word)
  end.length
end

puts get_real_words()

#puts is_real_word?("dog")

#puts search_for_words("I'm not a Brooster, I'm the son of a sea cook!")

