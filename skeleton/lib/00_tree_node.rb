require 'byebug'

class PolyTreeNode
  attr_reader :value, :parent, :children
  def initialize(value)
    @value = value
    @parent = nil
    @children = Array.new
  end

  def parent=(new_parent)
    unless @parent.nil?
      @parent.children.delete(self)
    end

    @parent = new_parent 
    unless new_parent.nil? || new_parent.children.include?(self)
      new_parent.children << self
    end
  end

  def add_child(child_node)
    child_node.parent = self
  end

  def remove_child(child_node)
    if child_node.parent.nil? 
      raise "This node gave birth to itself"
    else
      child_node.parent = nil
    end
  end

  def dfs(target)
    return self if self.value == target
    return nil if self.children.empty?

    self.children.each do |child|
      child.dfs(target)
    end

    nil
  end
end