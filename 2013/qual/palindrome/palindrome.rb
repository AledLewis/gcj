def palindromes number_start, number_end





  start_number_length = number_start.to_s.length
  end_number_length = number_end.to_s.length

  even_lengths = even_size_palindromes start_number_length , end_number_length
  odd_lengths = odd_size_palindromes start_number_length , end_number_length

  palindromes = (even_lengths + odd_lengths).sort.select {|number| number_start <= number && number <= number_end  }



end

def even_size_palindromes size_start , size_end
  even_palindromes =[]
  (size_start..size_end).select{|size| size%2==0}.each do |length|
    
    half_length = length / 2

    starting_number = 10 ** (half_length - 1)
    ending_number = (10 ** (half_length )) - 1

    (starting_number.. ending_number).each do |half_palindrome|
      even_palindromes << (half_palindrome.to_s+half_palindrome.to_s.reverse).to_i

    end


  end 

  even_palindromes 
  
end

def odd_size_palindromes size_start , size_end
  odd_palindrome_halfs  = []

  (size_start..size_end).select{|size| size%2==1}.each do |length|
    
    half_length = length / 2

    starting_number = (10 ** (half_length - 1)).to_i
    ending_number = (10 ** (half_length )) - 1

    (starting_number.. ending_number).each do |half_palindrome|
        odd_palindrome_halfs << (half_palindrome.to_s)
    end
  end

  odd_palindromes = []
  (0..9).each do |middle_digit|
    odd_palindrome_halfs.each do |half_string|
  
      half_string.to_i == 0 ? odd_palindromes << middle_digit : odd_palindromes << (half_string + middle_digit.to_s + half_string.reverse).to_i

    end


  end
  odd_palindromes

end

def palindrome? number
  number_string = number.to_s
  max_index = number_string.length - 1
  half_size = number_string.length / 2

  half_size.times do |index|
    return false if number_string[index] !=  number_string[max_index - index]
  end

  true
end

def find_fair_and_squares start_number , end_number
  #we will work with the sqroots as they will be smaller in cardinality
  
  start_sqrt = Math.sqrt(start_number).ceil
  end_sqrt = Math.sqrt(end_number).floor



  sqrt_palindromes_candidates = palindromes start_sqrt , end_sqrt

  fair_and_squares = sqrt_palindromes_candidates.select {|candidate| palindrome? candidate**2 }.map{|candidate| candidate **2}

  fair_and_squares

end

def test_fair_and_squares fair_and_squares 
  fair_and_squares.each do |fair_and_square|
    root =Math.sqrt(fair_and_square)
    return false unless root.floor == root && palindrome?( root.floor)
  end
  true
end

def run in_filename ,  out_filename
  File.open(in_filename) do |in_file|
    number_of_tests = in_file.gets.to_i
    File.open(out_filename , 'w') do |out_file|

      number_of_tests.times do |case_index|
        case_number = case_index + 1

        test_string = in_file.gets

        start_number = test_string.split[0].to_i
        end_number = test_string.split[1].to_i

        number_of_fair_and_squares = find_fair_and_squares(start_number,end_number).length

        out_file.puts "Case \##{case_number}: #{number_of_fair_and_squares}"


      end



    end
    
  end

end