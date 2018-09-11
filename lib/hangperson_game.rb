class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  MAX_NUM_GUESSES = 7
  
  attr_accessor :word, :guesses, :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ''
    @wrong_guesses = ''
  end

  # You can test it by running $ bundle exec irb -I. -r app.rb
  # And then in the irb: irb(main):001:0> HangpersonGame.get_random_word
  #  => "cooking"   <-- some random word
  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.new('watchout4snakes.com').start { |http|
      return http.post(uri, "").body
    }
  end
  
  def guess aGuess
    if (aGuess == nil) || !(aGuess =~ /[a-zA-Z]/)
      raise ArgumentError
    end
    
    aGuess.downcase!
    if (@guesses.include? aGuess) || (@wrong_guesses.include? aGuess)
      return false
    end  
    if @word.include? aGuess
      @guesses += aGuess
    elsif
      @wrong_guesses += aGuess
    end
  end
  
  def word_with_guesses
    stringReturn = Array.new(@word.length, '-')
    for char in @guesses.chars do
      for index in 0...@word.length do 
        stringReturn[index] = char if char == @word[index]
      end
    end
    
    return stringReturn.join()
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      return :win
    elsif (@wrong_guesses.length >= MAX_NUM_GUESSES) && (word_with_guesses != @word) 
      return :lose
    else
      return :play
    end
  end
  
end
