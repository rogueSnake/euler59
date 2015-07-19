class Database
  attr_accessor :data
  def initialize(data)
    @data = File.open(data, "r") do |file|
      file.each_line.with_object([]) do |line, words|
        words.push(line)
      end
    end
  end

end 

dictionary = Database.new("english_words.txt")
cipher_keeper = Database.new("cipher.txt")

def is_real_word?(possible_word)
  dictionary.data.each do |real_word|
    puts real_word
    puts possible_word
    puts (possible_word == real_word)
    return true if (possible_word == real_word)
  end
  false
end

def search_for_words(text)
  possible_words = text.split /\s|\.|\?|,|!/
  possible_words.each_with_object([]) do |possible_word, real_words|
    real_words.push(possible_word) if is_real_word?(possible_word)
  end.length
end
puts $dictionary
puts is_real_word?("heilaHitler!")
puts is_real_word?("vacuum")
#puts is_real_word?("dog")

#puts search_for_words("I'm not a Brooster, I'm the son of a sea cook!")

