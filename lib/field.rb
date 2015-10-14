class Field

  attr_accessor :cells, :height, :width

  def initialize(game)
    @game = game
    @width = @game.config['width'].to_i
    @height = @game.config['height'].to_i
    build_cells
  end

  def build_cells
    @cells = []
    @height.times do |i|
      @cells << Array.new(@width, 0)
    end
  end

  #----------------

  def reduce_cells
    cells.each_with_index do |row, row_index|
      row.each_with_index do |cell, cell_index|
        cells[row_index][cell_index] = cell - 1 if cell > 0
      end
    end
  end

  def set_cell(x, y, length)
    row = cells[y]
    if row
      row[x] = length
    end
  end

  def obstacle_at?(x, y)
    cells[y][x] > 0
  end

  #--------------

  def draw
    system('clear')
    result = border
    @height.times do |row|
      result << '|'
      @width.times do |column|
        result << (cells[row][column] > 0 ? '#' : ' ')
      end
      result << "|\n"
    end
    result << border
    puts result
  end

  def border
    "+#{'-' * @width}+\n"
  end

end