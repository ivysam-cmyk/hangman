class Game
  
  def blank_spaces 
    input_array = []
    (@ans.length - 1).times do
      input_array.push("_")
    end
    p input_array
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
    puts @ans
    #underscores representing the word show up
    blank_spaces 
    puts "Choose a letter, you have 9 tries in total"
  end
  
  def choose_letter
    do
      puts "Choose a letter"
      letter_chosen = gets.chomp
      break if letter_chosen.length == 1
      puts "Error, make sure you enter a single letter."
    end
      
  end

  def play_game
    find_words
    choose_letter
  end
end

hangman = Game.new
