class Player
  attr_reader :name, :playerSymbol
  @@playernum = 1
  def initialize
    puts "Player#{@@playernum}: What is your name?"
    @name = gets.chomp
    @playerNumber = @@playernum
    if @playerNumber == 1
      @playerSymbol = 'X'
      else
        @playerSymbol = 'O'
    end
    puts "#{@name} will be #{@playerSymbol}, Press enter to continue"
    gets
    @@playernum += 1
  end
end
  
class Board
  attr_accessor :boardState, :emptyBoardState
  
  def initialize
    @boardState = []
    @emptyBoardState = []
    (1..9).each do |num|
      @boardState.push(num.to_s)
      @emptyBoardState.push(num.to_s)
    end
  end

  def boardLine(startNum)
    puts "# #{@boardState[startNum]} | #{@boardState[startNum+1]} | #{@boardState[startNum+2]} #"
  end
  
  def boardSeperator
    puts '#---|---|---#'
  end
  
  def showBoard
    puts '#############'
    boardLine(0)
    boardSeperator
    boardLine(3)
    boardSeperator
    boardLine(6)
    puts '#############'
  end
end

class Game  
  
  def checkChoice?(player,choice)
    begin
      if @board.boardState[choice.to_i-1] == "X" || @board.boardState[choice.to_i-1] == "O"
        puts 'That choice is already taken!'
        raise
      elsif choice.to_i > 9 || choice.to_i < 1 
        puts 'Pick a number between 1-9 and that has not been taken already!'
        raise
      else 
        @board.boardState[choice.to_i-1] = player.playerSymbol
        return true
      end
    rescue
      choice = gets.chomp
      retry
    end
  end
  
  def turn(player)
    @board.showBoard
    puts "#{player.name}, your turn!"
    choice = gets.chomp
    choice = gets.chomp unless checkChoice?(player,choice)
    if checkWin?
      3.times {puts''}
      puts "#{player.name} Wins!"
      return true
    end
  end
  
  def checkWin?
    winning_conditions = [[0,4,8],[2,4,6],[0,3,6],[1,3,7],[2,5,8],[0,1,2],[3,4,5],[6,7,8]]
    winning_conditions.each do |con|
      if @board.boardState[con[0]] == 'X' && @board.boardState[con[1]] == 'X' && @board.boardState[con[2]] == 'X' 
        return true
      elsif @board.boardState[con[0]] == 'O' && @board.boardState[con[1]] == 'O' && @board.boardState[con[2]] == 'O' 
        return true
      end
    end
    return false
  end
  
  def checkTie?
    unless (@board.boardState & @board.emptyBoardState).any?
      puts "Tie! Everyone loses!" 
      return true
    end
  end
  
  def gameStart
    @board = Board.new
    restart = ''
    turn = 0
    win = 0
    while win == 0
        if turn == 0
          turn = 1
          win = 1 if turn(@player1)
        else
          turn = 0
          win = 1 if turn(@player2)
        end
        break if checkTie?
    end
    puts ''
    while restart != 'N'
      @board.showBoard
      puts ''
      puts 'Restart? (Y/N)'
      restart = gets.chomp.upcase
      if restart != 'Y' && restart != 'N'
        restart = gets.chomp
      elsif restart == 'Y'
        3.times { puts '' }
        gameStart
      else
        puts "Goodbye, #{@player1.name} and #{@player2.name}"
        break
      end
    end
  end

  def initialize
    @player1 = Player.new
    @player2 = Player.new
    gameStart
  end
end

Game.new
