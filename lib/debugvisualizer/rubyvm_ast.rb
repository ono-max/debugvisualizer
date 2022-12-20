module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.kind_of? ::RubyVM::AbstractSyntaxTree::Node
      {
        id: "rubyvm_ast_visualizer",
        name: "RubyVM As Tree",
        data: {
          kind: { tree: true },
          root: get_tree(data).last
        }
      }
    end
  end

  def self.inspect obj
    obj.inspect
  rescue Exception => e
    "failed to inspect: #{e.message}"
  end

  def self.get_tree data
    result = []
    data.children.each{|child|
      next if child.nil?

      node = {
        items: [],
        children: []
      }
      if child.kind_of? ::RubyVM::AbstractSyntaxTree::Node
        node[:items] << {
          text: child.type,
          emphasis: 'style1'
        }
        node[:children].push *get_tree(child)
      else
        node[:items] << {
          text: inspect(child),
          emphasis: 'style2'
        }
      end
      result << node
    }
    result
  end
end
