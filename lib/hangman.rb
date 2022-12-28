class HangMan
  attr_accessor :word
  def initialize 
    @word = generate_word
    @words_hints = Array.new(@word.length, '_')
  end

  def generate_word()
    dictionary = File.open('google-10000-english-no-swears.txt', 'r')
    array_words = []
    dictionary.each_line(chomp: true) {|line| array_words << line if line.length > 5 && line.length < 12}
    dictionary.close
    array_words.sample
  end

  def welcome_message
    puts 'Welcome to Hangman!'
  end

  def winners_message
    puts 'Congrats'
  end

  def gameflow
    welcome_message
    count = 12
    12.times do
      p 'Try to guess the word'
      p "Number of tries left: #{count}"
      guess = gets.chomp
      guess.each_char {|letter| @words_hints[@word.index(letter)] = letter if word.include?(letter)}
      return winners_message if guess == @word
        p @words_hints.join(' ')
        count -= 1
    end
  end
end

state = HangMan.new
state.gameflow
