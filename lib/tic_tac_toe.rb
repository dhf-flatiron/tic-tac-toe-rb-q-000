def display_board(board)
  puts " #{board[0]} | #{board[1]} | #{board[2]} "
  puts "-----------"
  puts " #{board[3]} | #{board[4]} | #{board[5]} "
  puts "-----------"
  puts " #{board[6]} | #{board[7]} | #{board[8]} "
end

def input_to_index(user_input)
  user_input.to_i - 1
end

def move(board, index, current_player)
  board[index] = current_player
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def turn(board)
  puts "Please enter 1-9:"
  input = gets.strip
  index = input_to_index(input)
  if valid_move?(board, index)
    move(board, index, current_player(board))
    display_board(board)
  else
    turn(board)
  end
end

def turn_count(board)
  turns = 0
  board.each { |pos| if pos == "X" or pos == "O" then turns += 1 end }
  turns
end

def current_player(board)
  turn_count(board).even? ? "X" : "O"
end

def other_player(board)
  turn_count(board).even? ? "O" : "X"
end

def position_taken?(board, index)
  !(board[index].nil?|| board[index] == " ")
end

WIN_COMBINATIONS = [
  [0,1,2],
  [3,4,5],
  [6,7,8],
  [0,3,6],
  [1,4,7],
  [2,5,8],
  [0,4,8],
  [2,4,6]
]

def won?(board)
  WIN_COMBINATIONS.any? do |w|
    #if ["X","O"].include?(board[w[0]]) and
    if position_taken?(board,w[0]) and
     board[w[0]] == board[w[1]] and board[w[1]] == board[w[2]] then
     return w
    end
  end
  false
end

def full?(board)
  (0..8).all? { |i| position_taken?(board,i) }
end

def draw?(board)
  #full?(board) and !won?(board) # that's annoying
  !won?(board) and full?(board)
end

def over?(board)
  won?(board) or draw?(board) #or full?(board) there is no full which isn't win or draw.
end

def winner(board)
  w = won?(board)
  if w then board[w[0]] end
end 

def play(board)
  until over?(board)
    turn(board)
  end
  if draw?(board) then
    puts "Cats Game!"
  end
  if won?(board) then
    puts "Congratulations #{winner(board)}!"
  end 
end

