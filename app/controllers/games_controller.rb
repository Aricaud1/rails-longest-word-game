require "open-uri"
require "json"

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @word = params[:word].upcase
    @letters = params[:letters].split

    if !existing_word?(@word, @letters)
      @message = "Le mot ne peut pas être formé à partir des lettres."
      @score = 0
    elsif !english_word?(@word)
      @message = "Le mot n'est pas un mot anglais valide."
      @score = 0
    else
      @message = "Bravo !"
      @score = @word.length
    end
  end

  private

  def existing_word?(word, letters)
    word.chars.all? do |letter|
      word.count(letter) <= letters.count(letter)
    end
  end

    def english_word?(word)
    url = "https://dictionary.lewagon.com/#{params[:word]}"
    response = URI.open(url).read
    json = JSON.parse(response)
    json["found"]
  end
end
