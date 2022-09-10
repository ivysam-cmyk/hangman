class Game
  
  def blank_spaces 
    @input_array = []
    (@ans.length - 1).times do
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
    puts @ans
    #underscores representing the word show up
    blank_spaces 
    puts "Choose a letter, you have 9 tries in total"
  end
  
  def choose_letter
     loop do
      puts "Choose a letter"
      @letter_chosen = gets.chomp
      break if (!@guess_array.include(@letter_chosen)) &&( @letter_chosen.length == 1)
      end
      puts "Error, make sure you enter a single letter."
    end
  
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


  def play_game
    find_words
    @guess_array = []
    @number_of_tries = 9
    9.times do
      if @number_of_tries < 9
        puts "You have #{@number_of_tries} tries remaining and you have guessed #{guess_array} until now. "
      end
      choose_letter
      verify_input
      @number_of_tries -= 1
    end
  end
end

hangman = Game.new
hangman.play_game
