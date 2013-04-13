#for every cell there has to be a direction, either north-south or east-west where every cell is the same or lower
class Lawn

  def initialize x,y
    @x_size = x
    @y_size = y
    @cells = Array.new(@y_size){Array.new(@x_size)}
  end

  def set_value x,y, value
    @cells[y][x] = value
  end

  def get_value x,y
    @cells[y][x]
  end

  def complete?
    
    @cells.each do |row|
      row.each do |value|
        return false if !value || !(1 <= value && value <=100)
      end
    end

    true

  end

  def cell_possible? x, y
    up_down_valid?(x,y )|| left_right_valid?(x, y)
  end

  def up_down_valid? x, y
    @y_size.times do |y_to_check|
      return false if @cells[y_to_check][x] > @cells[y][x]
    end
  end

  def left_right_valid? x, y
    @x_size.times do |x_to_check|
      return false if @cells[y][x_to_check] > @cells[y][x]
    end
  end

  def possible?
    return false if !complete?
    @x_size.times do |x|
      @y_size.times do |y|
        return false if !(cell_possible? x,y)
      end
    end
    true
  end

end

