class Board
  attr_accessor :cells

  def initialize
    self.reset!
  end

  def reset!
    self.cells = Array.new(9," ")
  end

  def display
    puts " #{cells[0]} | #{cells[1]} | #{cells[2]} "
    puts "-----------"
    puts " #{cells[3]} | #{cells[4]} | #{cells[5]} "
    puts "-----------"
    puts " #{cells[6]} | #{cells[7]} | #{cells[8]} "
  end

  def position(cell)
    self.cells[cell.to_i-1]
  end

  def full?
    cells.all? { |cell| cell == "X" || cell == "O"}
  end

  def turn_count
    cells.count { |cell| cell == "X" || cell == "O" }
  end

  def taken?(cell)
    self.position(cell) != " "
  end

  def valid_move?(move)
    !self.taken?(move) && move.to_i.between?(1,9)
  end

  def update(cell, player)
    self.cells[cell.to_i-1] = player.token
  end
end
