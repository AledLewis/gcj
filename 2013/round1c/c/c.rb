load 'interval_tree.rb'

class WallStrength < Range
  attr_reader :strength, :date

  def set_strength strength , date
    @strength = strength
    @date = date
  end

end

class Wall

  def initialize
    @walls = []
    @walls << WallStrength.new(1,2)

  end

  def breached? start_locn , end_locn , strength
    interesting_walls = IntervalTree::Tree.new(@walls).search(start_locn..end_locn)
    min_strength = interesting_walls.map{|wall| wall.strength}.min
    min_strength = 0 if min_strength.nil?
    return min_strength >= strength
    
  end

  def add_wall start_locn , end_locn , strength

  end
end


def c in_file_name , out_file_name
  File.open(in_file_name) do |in_file|
    File.open(out_file_name , 'w') do |out_file|
      number_of_tests = in_file.gets.to_i
      puts "#{number_of_tests} tests"

      number_of_tests.times do |case_index|
        case_number = case_index + 1
        puts "Case #{case_number}"
        
        

        

        out_file.puts "Case \##{case_number}: #{outcome}"
      end
    end
  end
end

