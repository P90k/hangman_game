
def generate_word()
  dictionary = File.open('google-10000-english-no-swears.txt', 'r')
  array_words = []
  dictionary.each_line(chomp: true) {|line| array_words << line if line.length > 5 && line.length < 12}
  dictionary.close
  array_words.sample
end

p generate_word
