require "open-uri"

class GamesController < ApplicationController
  def new
    charset = Array('A'..'Z')
    vowels = %w[A E U I O Y]
    @letters = Array.new(7) { charset.sample }
    3.times { @letters << vowels.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split
    @included = included?(@word, @letters)
    @english_word = english_word?(@word)
  end

  private

  def included?(word, letters)
    word.chars.all? { |letter| word.count(letter) <= letters.count(letter) }
  end

  def english_word?(word)
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{word}")
    json = JSON.parse(response.read)
    json['found']
  end
end
