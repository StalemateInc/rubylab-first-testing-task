class TreeNode
  attr_accessor :val, :left, :right

  def initialize(val)
    @val = val
    @left = nil
    @right = nil
  end

  def leaf?
    @right.nil? && @left.nil?
  end
end

class BinarySearchTree
  attr_reader :root, :values

  def initialize(initial)
    @values = []
    if initial.instance_of? Array
      raise ArgumentError, 'Can\'t initialize binary tree from an empty array.' if initial.empty?

      init_values = initial.uniq
      init_values.each(&method(:insert))
    else
      insert(initial)
    end
  end

  def insert(value, node = @root)
    insert_and_memorize(value, node)
    @values.push(value)
  end

  def binary_tree_paths(root = @root)
    paths = []
    get_path(root, '', paths)
    paths
  end

  def find(target)
    node = @root
    stack = []
    until node.nil?
      stack.push(node.val)
      break if target == node.val

      node = target < node.val ? node.left : node.right
    end
    stack.last == target ? stack.join('->') : nil
  end

  private
  def insert_and_memorize(value, node)
    return @root = TreeNode.new(value) if @root.nil?

    if value < node.val
      node.left ? insert_and_memorize(value, node.left) : node.left = TreeNode.new(value)
    elsif value > node.val
      node.right ? insert_and_memorize(value, node.right) : node.right = TreeNode.new(value)
    end
  end

  def get_path(node, path, paths)
    return if node.nil?

    path += '->' unless path.empty?
    path += node.val.to_s
    if node.leaf?
      paths.push(path)
    else
      get_path(node.left, path, paths)
      get_path(node.right, path, paths)
    end
  end

end