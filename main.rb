require "yaml"
require 'pry-byebug'
class Game
  def initialize
    @end_game  = false
    find_words
    @guess_array = []
    @number_of_tries = (@ans.length * 2 )
    
  end
  def blank_spaces 
    @input_array = []
    (@ans.length).times do
      @input_array.push("_")
    end
    p @input_array
  end
  #comp chooses 5-12 letter word
  def find_words
    suitable_words = []
    file  = File.open("data.txt",'r')
    while !file.eof?
      line = file.readline
      if (line.length > 4 && line.length < 13)
        suitable_words.push(line)
      end
    end
    @ans = suitable_words.sample
    @ans = @ans.delete("\n") 
    puts @ans
    #underscores representing the word show up
    blank_spaces 
    puts "Choose a letter, you have #{@number_of_tries} tries in total"
  end
  
  def choose_letter
    loop do
      puts "Choose a letter, or save by typing 'save'."
      @letter_chosen = gets.chomp
      if (!@guess_array.include?(@letter_chosen)) &&( @letter_chosen.length == 1)
        break
      elsif @letter_chosen == "save"
        save_game
        break
      end
    end
      puts "Error, make sure you enter a single letter."
    
  end


  def verify_input
    @split_ans = @ans.split("")
    @split_ans.each do |letter|
      if letter == @letter_chosen
        #find index of letter guessed where there may be more than 1 letter
        @letter_index_array = @split_ans.each_index.select {|i| @split_ans[i] == letter}  
        #replace the "_" with the actual letter
        @letter_index_array.each do |i|
          @input_array[i] = letter
        end  
      end
    end
    @guess_array.push(@letter_chosen)
    p @input_array

  end

  def check_ans
    if @input_array.join == @ans
      puts "You have won"
      end_game = true
    elsif @input_array.join != @ans
      puts "You have lost."
      #end_game is still false.
    end
  end

  def save_game
    File.open("game_save.yml", 'w') { |f| YAML.dump(self, f) } #f at the end is i/o which is the file being saved to
    exit
  end



  def self.play_loaded
    #make the loaded game continue here
    (@number_of_tries).times do 
      if @number_of_tries < (@ans.length * 2)
        puts "You have #{@number_of_tries} tries remaining and you have guessed #{@guess_array} until now. "
      end
      choose_letter
      verify_input
      check_ans
      if end_game == true
        break
      end
      @number_of_tries -= 1
    end
    if @input_array.join != @ans
      puts "You have lost."
    end
  end

  def load_game
    loaded_game = YAML.load_file("game_save.yml",permitted_classes: [Game]) 
    p loaded_game
    loaded_game.play_loaded
  end
  
  def play_game
    puts "Start a new game or load saved game by typing 'load'."
    @initial_dec = gets.chomp
    if @initial_dec == "load"
      load_game
    else
      (@number_of_tries).times do 
        if @number_of_tries < (@ans.length * 2)
          puts "You have #{@number_of_tries} tries remaining and you have guessed #{@guess_array} until now. "
        end
        puts "letter about to be chosen."
        choose_letter
        verify_input
        check_ans
        if @end_game == true
          break
        end
        @number_of_tries -= 1
      end
    end
  end
end
hangman = Game.new
hangman.play_game

