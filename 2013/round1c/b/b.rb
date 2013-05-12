def do_x_move x_displacement, y_displacement , hop_size , moves
  if x_displacement.abs < hop_size
    if x_displacement < 0
      moves<< "W"
      
      next_move x_displacement - hop_size , y_displacement , hop_size + 1 , moves
    else 
      moves << "E" 
      
      next_move x_displacement + hop_size , y_displacement , hop_size + 1 , moves
    end
  else 
    if x_displacement < 0
      moves << "E"
      
      next_move x_displacement + hop_size , y_displacement , hop_size + 1 , moves
    else 
      moves << "W"
      
      next_move x_displacement - hop_size , y_displacement , hop_size + 1 , moves
    end
  end
end

def do_y_move x_displacement, y_displacement , hop_size , moves
  if y_displacement.abs < hop_size
    if y_displacement < 0
      moves<< "S"
      
      next_move x_displacement , y_displacement - hop_size , hop_size + 1 , moves
    else 
      moves << "N" 
      
      next_move x_displacement , y_displacement + hop_size , hop_size + 1 , moves
    end
  else 
    if y_displacement < 0
      moves << "N"
      
      next_move x_displacement , y_displacement + hop_size , hop_size + 1 , moves
    else 
      moves << "S"
      
      next_move x_displacement , y_displacement - hop_size , hop_size + 1 , moves
    end
  end
end


def next_move x_displacement, y_displacement , hop_size , moves
  return moves if x_displacement == 0 and y_displacement == 0
  if x_displacement.abs > y_displacement.abs
    do_x_move x_displacement, y_displacement , hop_size , moves
  else
    do_y_move x_displacement, y_displacement , hop_size , moves
  end
     
end


def b in_file_name , out_file_name
  File.open(in_file_name) do |in_file|
    File.open(out_file_name , 'w') do |out_file|
      number_of_tests = in_file.gets.to_i
      puts "#{number_of_tests} tests"

      number_of_tests.times do |case_index|
        case_number = case_index + 1
        puts "Case #{case_number}"
        target =in_file.gets.split
        x_displacement = 0 - target[0].to_i 
        y_displacement = 0 - target[1].to_i

        moves = next_move x_displacement , y_displacement , 1 , []
        

        

        out_file.puts "Case \##{case_number}: #{moves.join}"
      end
    end
  end
end

