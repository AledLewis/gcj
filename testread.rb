

def codejam in_file_name , out_file_name
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

