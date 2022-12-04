module DebugVisualizer
  DebugVisualizer.register do |data|
    if defined?(REXML::Document) && data.kind_of?(REXML::Document)
      {
        id: "rexml_visualizer",
        name: "REXML As Tree",
        data: {
          kind: { tree: true },
          root: get_tree(data)[0]
        }
      }
    end
  end

  def self.get_tree(elems)
    result = []
    elems.each_element{|elem|
      child = []
      elem.attributes.each_attribute{|atr|
        items = []
        items << {
          text: "#{atr.name}: ",
          emphasis: 'style2'
        }
        items << {
          text: atr.value,
          emphasis: 'style2'
        }
        child << {
         items: items, 
         children: []
        }
      }
      if elem.has_elements?
        child.push *get_tree(elem)
      end
      tree = {
        items: [
          {
            text: elem.name,
            emphasis: 'style1'
          }          
        ],
        children: child
      }
      if elem.text && elem.text.strip != ""
        tree[:items] << {
          text: ' ' * 2 + elem.text.strip
        }
      end
      result << tree
    }
    result
  end
end
