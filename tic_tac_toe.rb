# tic_tac_toe.rb

def initialize_board
  board = {}
  (1..9).each { |position| board[position] = ' ' }
  board
end

def draw_board(board)
  system 'clear'
  puts
  puts " #{ board[1] } | #{ board[2] } | #{ board[3] } "
  puts '-----------'
  puts " #{ board[4] } | #{ board[5] } | #{ board[6] } "
  puts '-----------'
  puts " #{ board[7] } | #{ board[8] } | #{ board[9] } "
  puts
end

def empty_positions(board)
  board.keys.select { |position| board[position] == ' ' }
end

def player(board)
  begin
    puts 'Choose a square! (1 - 9)'
    position = gets.chomp.to_i
  end until empty_positions(board).include?(position)
  board[position] = 'X'
end

def computer(board)
  position = empty_positions(board).sample
  board[position] = 'O'
end

def check_winner(board)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 4, 7], \
                   [2, 5, 8], [3, 6, 9], [1, 5, 9], [3, 5, 7]]
  winning_lines.each do |line|
    return 'You' if board.values_at(*line).count('X') == 3
    return 'The computer' if board.values_at(*line).count('O') == 3
  end
  nil
end

board = initialize_board
draw_board(board)

begin
  player(board)
  computer(board)
  draw_board(board)
  winner = check_winner(board)
end until winner || empty_positions(board).empty?

if winner == 'You'
  puts "Awesome! #{ winner} won!"
elsif winner == 'The computer'
  puts "#{ winner } won... Better luck next time."
else
  puts 'It\'s a tie!'
end

puts
