ary = []
16.times |i| { ary << i }

sub_ary = []
ary.each do |x|
  sub_ary << x
  if sub_ary.length == 4
    puts sub_ary.join ','
    sub_ary = []
  end
end



class Tree
  attr_accessor :children, :node_name

  def initialize(tree={})
    @children = []
    @node_name = tree.keys.first
    tree[@node_name].each_pair do |k,v|
      @children << Tree.new({k => v})
    end
  end

  def visit_all(&block)
    visit &block
    children.each {|c| c.visit_all &block}
  end

  def visit(&block)
    block.call self
  end
end

test_init = {'grandpa' => { 'dad' => {'child 1' => {}, 'child 2' => {} }, 'uncle' => {'child 3' => {},
'child 4' => {} } } }

tree = Tree.new test_init

tree.visit_all { |n| puts n.node_name }

class Grep
  def self.find(pattern, file)
    File.open(file, 'r').each do |line|
      puts line if line =~ /#{pattern}/
    end
  end
end