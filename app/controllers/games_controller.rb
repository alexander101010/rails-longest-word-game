require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    grid_size = 8
    @letters = Array.new(grid_size) { [*'A'..'Z'].sample }
  end

  def score
    @attempt = params[:word].downcase
    @letters = params[:letters]
    # @letters = "M P I C V H R X"
    response = open("https://wagon-dictionary.herokuapp.com/#{@attempt}")
    dict = JSON.parse(response.read)
    english_word = (dict['found'] == true) # returns boolean, true if valid word in dict
    # if valid word && word is in the array

    word_validity = word_in_grid(@attempt, @letters)
    # should return true/false
    if word_validity && english_word == true
      # @bold = 'Congratulations'
      @result = "Congratulations! #{@attempt.upcase} is a valid word. Huzzah."
    elsif word_validity == false
      @result = "Sorry but #{@attempt.upcase} can't be built out of #{@letters}"
    else
      # @bold = @attempt
      @result = "#{@attempt} is not a valid English word, you goon."
    end
  end
end

private

  def letter_count(string)
    letter_freq = Hash.new(0)
    string.split('').each do |letter|
      letter_freq[letter] += 1
    end
    letter_freq
  end

  def word_in_grid(attempt, letters)
    attempt_freq = letter_count(attempt.downcase)
    letters_freq = letter_count(letters.gsub(' ', '').downcase)
    attempt.split('').all? { |letter| attempt_freq[letter] <= letters_freq[letter] }
  end
