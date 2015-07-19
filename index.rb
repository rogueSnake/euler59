class Database
  attr_accessor :data
  def initialize(data)
    @data = File.open(data, "rb") do |file|
      file.each_line.with_object([]) do |line, words|
        line = line.split /\s|\.|\?|,|!/
        line.each do |word|
          words.push(word.strip)
        end
      end
    end
  end
end 

class Dictionary < Database
  def is_real_word?(possible_word) 
    verified = false
    #puts (possible_word == "vacuum")
    @data.each do |real_word|
     #puts (real_word)
     #puts (real_word.slice(0, 1))
     #puts (real_word.slice(0, 1) == "v")
     #puts (real_word == "vacuum")
      verified = true if (possible_word == real_word)
      break if (verified == true)
    end
    verified
  end

  def search_for_words(text)
    possible_words = text.split /\s|\.|\?|,|!/
    possible_words.each_with_object([]) do |possible_word, real_words|
      real_words.push(possible_word) if self.is_real_word?(possible_word)
    end.length
  end
end

class Cipher_keeper < Database
  def start_decryption(key)
    character_1 = key.slice(0, 1)
    character_2 = key.slice(1, 2)
    character_3 = key.slice(2, 3)
    i = 1
    current_character = 0
    (0..20).each_with_object([]) do |data_index, decrypted_data|
      current_character = key.slice(i - 1, i).ord
      decrypted_data.push((@data[data_index].to_i^current_character).chr)
      i == 3 ? i = 1 : i += 1
    end.join
  end

  def attempt_decryption(key)
    character_1 = key.slice(0, 1)
    character_2 = key.slice(1, 2)
    character_3 = key.slice(2, 3)
    i = 1
    current_character = 0
    @data.each_with_object([]) do |encrypted_datum, decrypted_data|
      current_character = key.slice(i - 1, i).ord
      decrypted_data.push((encrypted_datum.to_i^current_character).chr)
      i == 3 ? i = 1 : i += 1
    end.join
  end
end

dictionary = Dictionary.new("english_words.txt")
cipher_keeper = Cipher_keeper.new("cipher.txt")

#def search_for_words(text)
#  possible_words = text.split /\s|\.|\?|,|!/
#  possible_words.each_with_object([]) do |possible_word, real_words|
#    real_words.push(possible_word) if is_real_word?(possible_word)
#  end.length
#end

#puts dictionary.search_for_words("I'm not a Brooster, I'm the son of a sea cook!")

#puts cipher_keeper.attempt_decryption('cat')

j = 0
('aaa'..'zzz').each_with_object([]) do |possible_key, probable_keys|
  probable_keys.push(possible_key) if ((dictionary.search_for_words(cipher_keeper.start_decryption(possible_key))) > 1)
end.each do |probable_key|
  puts cipher_keeper.attempt_decryption(probable_key) if (dictionary.search_for_words(cipher_keeper.attempt_decryption(probable_key)) > 10)
end
