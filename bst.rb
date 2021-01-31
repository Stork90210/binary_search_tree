require 'pry'

class Node
  include Comparable
  attr_accessor :data, :left, :right
  
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  # def <=>(other_data)
  #   data <=> other_data.data
  # end

end

class Tree

  attr_accessor :root, :data

  def initialize(array)
    @data = array.sort.uniq
    @root = build_tree(@data)
  end

  def build_tree(array)
    if array.length > 0
      middle = (array.length - 1) / 2
      node = Node.new(array[middle])
      node.left = build_tree(array[0...middle])
      node.right = build_tree(array[(middle + 1)..-1])
      node
    else
      nil
    end
  end

  def insert(value, node = @root)
    # check if bigger or smaller then root, if smaller, then recurse left, other recurse right
    if value < node.data
      node.left.nil? ? node.left = Node.new(value) : insert(value, node.left)
    elsif value > node.data
      node.right.nil? ? node.right = Node.new(value) : insert(value, node.right)
    end
  end

  def delete(value, node = @root)
    return node if node.nil?
    
    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      return node.right if node.left.nil?
      return node.left if node.right.nil?

      successor = find_successor(node.right)
      node.data = successor.data
      node.right = delete(successor.data, node.right)
    end
    node
  end

  def find(value, node = @root)
    return node if node.nil? || node.data == value

    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def level_order(node = @root)
    queue = []
    list = []
    queue << node
    until queue.empty?
      first_in_queue = queue.shift
      list << first_in_queue.data
      queue << first_in_queue.left unless first_in_queue.left.nil?
      queue << first_in_queue.right unless first_in_queue.right.nil?
    end
    list
  end

  def level_order_recursive(node = @root, queue = [], list = [])
    list << node.data
    queue << node.left unless node.left.nil?
    queue << node.right unless node.right.nil?
    return list if queue.empty?

    level_order_recursive(queue.shift, queue, list)
  end

  def in_order(node = @root, list = [])
    return if node.nil?

    in_order(node.left, list)
    list << node.data
    in_order(node.right, list)
    list
  end

  def pre_order(node = @root, list = [])
    return if node.nil?

    list << node.data
    pre_order(node.left, list)
    pre_order(node.right, list)
    list
  end

  def post_order(node = @root, list = [])
    return if node.nil?
     
    post_order(node.left, list)
    post_order(node.right, list)
    list << node.data
    list
  end

  def height(node = @root)
    return -1 if node.nil?

    max(height(node.left), height(node.right)) + 1
  end

  def max(num1, num2)
    num1 < num2 ? num2 : num1
  end

  def depth(node)
    height - height(node)
  end

  def balanced?(node = @root)
    return true if node.nil?
    
    left_height = height(node.left)
    right_height = height(node.right)
    return true if (left_height - right_height).abs <= 1 && balanced?(node.left) && balanced?(node.right)

    false
  end

  def rebalance(node = @root)
    self.data = in_order(node)
    self.root = build_tree(data)
  end





    


  #  Algorithm Inorder(tree)
  #  1. Traverse the left subtree, i.e., call Inorder(left-subtree)
  #  2. Visit the root.
  #  3. Traverse the right subtree, i.e., call Inorder(right-subtree)





  # Checks if node has children. Returns nil for no children, -1 for left child, 1 for right child, 2 for 2 childs.
  # def count_children(node)
  #   if node.left.nil? && node.right.nil?
  #     return nil
  #   elsif !node.left.nil? && node.right.nil?
  #     return -1
  #   elsif node.left.nil? && !node.right.nil?
  #     return 1
  #   else
  #     return 2
  #   end
  # end

  # Finds nearest succesor, takes node.right as startpoint
  def find_successor(node)
    return node if node.left.nil?
    find_successor(node.left)
  end      
        

      


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

rand_array = Array.new(15) { rand(1..100) }
tree1 = Tree.new(rand_array)
puts tree1.balanced?
puts "Level order: #{tree1.level_order_recursive}"
puts "Pre order: #{tree1.pre_order}"
puts "Post order: #{tree1.post_order}"
puts "In order: #{tree1.in_order}"
puts "Adding 7 random number between 101 & 200..."
7.times do
  tree1.insert(rand(101..200))
end
puts "Balanced = #{tree1.balanced?}"
puts "Rebalancing..."
tree1.rebalance
puts "Balanced = #{tree1.balanced?}"
puts "Level order: #{tree1.level_order_recursive}"
puts "Pre order: #{tree1.pre_order}"
puts "Post order: #{tree1.post_order}"
puts "In order: #{tree1.in_order}"
