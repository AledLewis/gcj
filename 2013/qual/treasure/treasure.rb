class Chest
  attr_reader :keys, :required_key , :id

  def initialize required_key, keys , id
    @keys = keys
    @required_key = required_key
    @id = id
  end

end 




def required_keys chests
  chests.map {|chest| chest.required_key }
end

def open_candidates chests , have_keys
  chests.select{|chest| have_keys.include? chest.required_key }
end

def open_chest chest , chests, have_keys
  chests = chests.delete chest
  have_keys.delete_at(have_keys.index(chest.required_key)) 
  chest.keys.each do |key|
    have_keys << key
  end
end

class SolveTree 
  attr_reader :value

  def initialize value=-1
    @nodes = []
    @value = value
  end

  def add_tree value
    new_tree = SolveTree.new( value) 
    @nodes << new_tree
    new_tree
  end

  def purge_node value
    @nodes.delete_if{|node| node.value == value}
  end

  def results 
    result = []

    if @nodes.size > 0 
      
      result = @nodes.map do |node|
        node.results
      end

    else 
      
      result = [@value]

    end
            
    return result
    
  end
end


def solve chests , keys , solution_tree
  
  openable = open_candidates chests , keys
  
  throw :dead_end if openable.size == 0

  openable.each do |chest|
    new_tree = solution_tree.add_tree chest.id
    candidate_chests = chests.clone
    candidate_keys = keys.clone

    open_chest chest, candidate_chests , candidate_keys
    begin 
      solve candidate_chests , candidate_keys , new_tree if candidate_chests.size > 0
    rescue 
      puts "Dead end"
      solution_tree.purge_node chest.id
    end
  end

end



