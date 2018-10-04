class Game
  WIN_COMBINATIONS = [
  [0, 1, 2],
  [3, 4, 5],
  [6, 7, 8],
  [0, 3, 6],
  [1, 4, 7],
  [2, 5, 8],
  [0, 4, 8],
  [2, 4, 6],
  ]

  attr_accessor :board, :player_1, :player_2

  def initialize(player_1=Players::Human.new("X"), player_2=Players::Human.new("O"), board=Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count.odd? ? player_2 : player_1
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      board.cells[combo[0]] != " " &&
      board.cells[combo[0]] == board.cells[combo[1]] &&
      board.cells[combo[1]] == board.cells[combo[2]]
    end
  end

  def draw?
    board.full? && !won?
  end

  def over?
    won? || draw?
  end

  def winner
    board.cells[won?[0]] if won?
  end

  def turn
    input = current_player.move(board)
    board.valid_move?(input) ? board.update(input, current_player) : turn
  end

  def start
    puts "Ohhh, sounds like an interesting match..."
    puts "Here's the board:"
    board.display
    puts "\n\n"
  end

  def play
    start
    until over?
      puts "Player #{current_player.token}, it's your turn!"
      turn
      puts "A move was made!"
      board.display
      puts "\n\n"
    end
    puts "The game is over..."
    board.display
    puts won? ? "Congratulations #{winner}!" : "Cat's Game!"
    puts "Want to play again? Y/N"
    input = gets.strip

    if input == "Y"
      game.play
    elsif input == "N"
      puts "Alrighty then, see you next time!"
      exit
    end
  end
end
