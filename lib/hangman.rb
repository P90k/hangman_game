# frozen_string_literal: true

class HangMan
  attr_accessor :word

  def initialize
    @word = generate_word
    @word_hints = Array.new(@word.length, '_')
    @guessed_letters = []
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

  def user_instructions(tries)
    puts 'Try to guess the letter'
    puts "Number of tries left: #{12 - tries}"
    puts "Letters that have been guessed: #{@guessed_letters.join(', ')}"
  end

  def gameflow
    welcome_message
    p @word
    12.times do |tries|
      user_instructions(tries)
      letter = gets.chomp.downcase
      remember_guessed_letter(letter)
      @word.split('').each_with_index { |char, index| @word_hints[index] = letter if char == letter }
      return winners_message if @word_hints.join == @word

      p @word_hints.join(' ')
    end
  end
end

state = HangMan.new
state.gameflow
