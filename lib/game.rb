class Game
  attr_accessor :board, :player_1, :player_2, :cells

  WIN_COMBINATIONS = [
    [0,1,2],
    [3,4,5],
    [6,7,8],
    [0,3,6],
    [1,4,7],
    [2,5,8],
    [0,4,8],
    [6,4,2]
  ]

  def initialize(player_1 = Player::Human.new("X"), player_2 = Player::Human.new("O"), board = Board.new)
    @player_1 = player_1
    @player_2 = player_2
    @board = board
  end

  def current_player
    board.turn_count.even? ? player_1 : player_2
  end

  def over?
    won? || draw?
  end

  def won?
    WIN_COMBINATIONS.detect do |combo|
      combo.all? { |position| board.cells[position] == player_1.token } ||
      combo.all? { |position| board.cells[position] == player_2.token }
    end
  end

  def draw?
    !won? && board.full?
  end

  def winner
    board.cells[won?.first] if won?
  end

  def turn
    player = current_player
    current_move = player.move(board)

    if board.valid_move?(current_move)
      board.update(current_move, player)
      # system("clear")
      board.display
      sleep 0.5
    else
      turn
    end

  end

  def play
    turn until over?
    puts "Congratulations #{winner}!" if won?
    puts "Cats Game!" if draw?
  end

  def self.start


    puts "How many players?"
    puts ""
    puts "0. Computer vs Itself"
    puts "1. One Player vs Computer"
    puts "2. Two players"

    input = gets.strip
    if input == "0"
      game = Game.new(player_1 = Player::Computer.new("X"), player_2 = Player::Computer.new("O"))
    elsif input == "1"
      puts "Would you like to go first? (Y/N)"
      answer = gets.strip
      if answer == "y".downcase
        game = Game.new(player_1 = Player::Human.new("X"), player_2 = Player::Computer.new("O"))
      elsif answer == "n".downcase
        game = Game.new(player_1 = Player::Computer.new("X"), player_2 = Player::Human.new("O"))
      end
    elsif input == "2"
      puts "Player One, please enter your name"
      player_1 = gets.strip
      puts "Welcome #{player_1}!"
      puts "Player Two please enter your name"
      player_2 = gets.strip
      puts "Welcome #{player_2}!"
      game = Game.new(player_1 = Player::Human.new("X"), player_2 = Player::Human.new("O"))
    end
    game.play
  end


end
