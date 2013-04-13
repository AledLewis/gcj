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

def lawnmower in_file_name , out_file_name
  File.open(in_file_name) do |in_file|
    File.open(out_file_name , 'w') do |out_file|
      number_of_tests = in_file.gets.to_i
      puts "#{number_of_tests} tests"

      number_of_tests.times do |case_index|
        case_number = case_index + 1
        puts "Case #{case_number}"
        lawn_size_string = in_file.gets.chomp
        height_of_lawn = lawn_size_string.split[0].to_i
        width_of_lawn = lawn_size_string.split[1].to_i
        puts "Lawn height #{height_of_lawn} with width #{width_of_lawn}"

        lawn = Lawn.new width_of_lawn , height_of_lawn

        height_of_lawn.times do |y|
          lawn_row_string = in_file.gets.chomp
          lawn_row_string.split.each_with_index do |required_height_string, x|
            lawn.set_value x, y, required_height_string.to_i
          end
        end

        lawn.possible? ? outcome = "YES" : outcome = "NO"

        out_file.puts "Case \##{case_number}: #{outcome}"
      end
    end
  end
end

