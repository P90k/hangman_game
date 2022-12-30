# frozen_string_literal: true

class HangMan
  attr_accessor :word

  def initialize
    @word = generate_word
    @word_hints = Array.new(@word.length, '_')
    @guessed_letters = []
    @tries = 12
  end

  def game_menu
    puts 'Type "start" to start the game'
    puts 'Type "saved" to access saved games'
    puts 'Type "exit" to exit the game.'
    choice = gets.chomp.downcase
    return if choice == 'start'

    if choice == 'saved'
      open_saved_game
      exit
    end
    exit if choice == 'exit'
  end

  def generate_word
    dictionary = File.open('google-10000-english-no-swears.txt', 'r')
    array_words = []
    dictionary.each_line(chomp: true) { |line| array_words << line if line.length > 5 && line.length < 12 }
    dictionary.close
    array_words.sample
  end

  def welcome_message
    puts 'Welcome to Hangman!'
  end

  def winners_message
    puts "Congrats, correct word is #{@word}"
  end

  def remember_guessed_letter(letter)
    @guessed_letters.push(letter) unless @guessed_letters.include?(letter)
  end

  def loop
    while @tries.positive?
      @tries -= 1

      user_instructions
      letter = gets.chomp.downcase
      save_game if letter == '--s'
      exit if letter == '--e'

      remember_guessed_letter(letter)
      @word.split('').each_with_index { |char, index| @word_hints[index] = letter if char == letter }
      return winners_message if @word_hints.join == @word
    end
  end

  def user_instructions
    puts '--s -> save game | --e -> exit game'
    puts 'Guess letter'
    puts "Number of tries left: #{@tries}"
    puts "Letters that have been guessed: #{@guessed_letters.join(', ')}"
    puts @word_hints.join(' ')
    puts "\n"
  end

  def save_game
    File.open('saved_game', 'w') do |output|
      output.puts(Marshal.dump(self))
    end
    exit
  end

  def open_saved_game
    File.open('saved_game', 'r') do |input|
      Marshal.load(input).loop
    end
  end

  def gameflow
    welcome_message
    game_menu
    loop
  end
end

state = HangMan.new
state.gameflow
