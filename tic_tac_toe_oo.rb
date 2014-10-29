# tic_tac_toe_oo.rb

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], \
                   [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]

  def initialize
    @board = {}
    (1..9).each { |position| @board[position] = Square.new(' ') }
  end

  def empty_squares
    @board.select { |_, square| square.empty? }.values
  end

  def empty_positions
    @board.select { |_, square| square.empty? }.keys
  end

  def all_squares_marked?
    empty_squares.size == 0
  end

  def three_squares_in_a_row?(marker)
    WINNING_LINES.each do |line|
      return true if @board[line[0]].value == marker &&
                     @board[line[1]].value == marker &&
                     @board[line[2]].value == marker
    end
    false
  end

  def mark_square(position, marker)
    @board[position].mark(marker)
  end

  def draw
    system 'clear'
    puts
    puts " #{@board[1]} | #{@board[2]} | #{@board[3]} "
    puts '-----------'
    puts " #{@board[4]} | #{@board[5]} | #{@board[6]} "
    puts '-----------'
    puts " #{@board[7]} | #{@board[8]} | #{@board[9]} "
    puts
  end
end

class Player
  attr_reader :marker, :name

  def initialize(name, marker)
    @name = name
    @marker = marker
  end
end

class Square
  attr_reader :value

  def initialize(value)
    @value = value
  end

  def empty?
    @value == ' '
  end

  def mark(marker)
    @value = marker
  end

  def to_s
    @value
  end
end

class Game
  def initialize
    @board = Board.new
    @human = Player.new('You', 'X')
    @computer = Player.new('The computer', 'O')
    @current_player = @human
  end

  def current_player_marks_square
    if @current_player == @human
      begin
        puts 'Choose a square! (1 - 9)'
        position = gets.chomp.to_i
      end until @board.empty_positions.include?(position)
    else
      position = @board.empty_positions.sample
    end
    @board.mark_square(position, @current_player.marker)
  end

  def alternate_player
    if @current_player == @human
      @current_player = @computer
    else
      @current_player = @human
    end
  end

  def current_player_wins?
    @board.three_squares_in_a_row?(@current_player.marker)
  end

  def play
    @board.draw
    loop do
      current_player_marks_square
      @board.draw
      if current_player_wins?
        puts "#{@current_player.name} won!"
        break
      elsif @board.all_squares_marked?
        puts 'It\'s a tie!'
        break
      else
        alternate_player
      end
    end
    puts "\nThanks for playing!"
  end
end

Game.new.play
