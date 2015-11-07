class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  
  def initialize(word)
    @word = word.downcase
    @guesses = ""
    @wrong_guesses =""
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end
  
  def word
    'glorp'
  end
  
  attr_accessor :guesses
      
  attr_accessor :wrong_guesses
  
  def guess letter
    raise ArgumentError, 'Argument is nil' unless letter  
    raise ArgumentError, 'Argument is not a single ascii letter' unless letter=~ /^[a-z]$/i  
    raise RuntimeError, 'too many wrong guesses' unless @wrong_guesses.length < 7

    letter.downcase!
    if (@guesses.include?( letter ) || @wrong_guesses.include?( letter )) 
      false
    else #It's a new guess so check whether good or wrong guesss 
      if @word.include? letter
        @guesses+= letter
      else
        @wrong_guesses+= letter
      end
      true
    end
  end
  
  def word_with_guesses
    ret=''
    @word.chars.each do  |s| 
      if @guesses.include? s
        ret+=s
      else
        ret+='-'
      end
    end
    ret
  end
  
  def check_win_or_lose
    if word_with_guesses == @word
      :win
    elsif @wrong_guesses.length < 7
      :play
    else
      :lose
    end
  end
  
    
    
  
  
    
end
