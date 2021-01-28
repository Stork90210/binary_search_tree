require 'pry'

class Node
  include Comparable
  attr_accessor :data, :left, :right
  
  def initialize(data)
    @data = data
    @left = nil
    @right = nil
  end

  def <=>(other_data)
    data <=> other_data.data
  end

end

class Tree

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

  def insert(value)
    # check if bigger or smaller then root, if smaller, then recurse left, other recurse right
    if value < @root
      


  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left
  end

end

tree1 = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree1.build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])


binding.pry