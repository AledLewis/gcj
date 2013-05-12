
$consonants= "bcdfghjklmnpqrstvwxyz"

def find_n_consonants string, n
  n_consonant_locations =[]
  string.size.times do |char_check_index|
    is_run = true
    n.times do |consonant_run_index|
      if consonant_run_index + char_check_index < string.size
        
        is_run = false unless $consonants.include?(string[char_check_index+consonant_run_index])
      else
        is_run = false
      end
    end
    n_consonant_locations << char_check_index if is_run

  end
  n_consonant_locations
end

def preceding_chars_to_substr substr_start_index
  substr_start_index
end

def following_chars_to_substr length_of_string, substr_start_index, substr_length
  length_of_string - substr_start_index - substr_length
end

def possible_substrings_from_point length_of_string, substr_start_index , substr_length
  return (preceding_chars_to_substr (substr_start_index) + 1) * (following_chars_to_substr(length_of_string , substr_start_index , substr_length) +1 )
end

def find_complexity_of_name name_string, n
  consonant_run_locations = find_n_consonants name_string, n
  substring_counts = []
  consonant_run_locations.size.times do |consonant_run_index_index|

    name_index = consonant_run_locations[consonant_run_index_index]

    if consonant_run_index_index == 0 
      substring_counts << possible_substrings_from_point( name_string.size, name_index , n)
    else
      previous_index = consonant_run_locations[consonant_run_index_index - 1]
      substring_counts << possible_substrings_from_point( name_string.size - (previous_index+1), name_index - (previous_index+1), n)
    end


  end
  substring_counts.reduce(:+)
end


def a in_file_name , out_file_name
  File.open(in_file_name) do |in_file|
    File.open(out_file_name , 'w') do |out_file|
      number_of_tests = in_file.gets.to_i
      puts "#{number_of_tests} tests"

      number_of_tests.times do |case_index|
        case_number = case_index + 1
        puts "Case #{case_number}"
        case_line = in_file.gets.split
        name_string = case_line[0]
        n = case_line[1].to_i
        outcome = find_complexity_of_name name_string , n

        outcome = 0 if outcome.nil?

        out_file.puts "Case \##{case_number}: #{outcome}"
      end
    end
  end
end

