module DebugVisualizer
  DebugVisualizer.register do |data|
    if defined?(REXML::Document) && data.kind_of?(REXML::Document)
      {
        id: "rexml_visualizer",
        name: "REXML As Tree",
        data: {
          kind: { tree: true },
          root: get_rexml_as_tree(data)[0]
        }
      }
    end
  end

  def self.get_rexml_as_tree(elems)
    result = []
    elems.each_element{|elem|
      items = [
        {
          text: elem.name,
          emphasis: 'style1'
        }
      ]
      elem.attributes.each_attribute{|atr|
        items << {
          text: "  #{atr.name} =",
        }
        items << {
          text: atr.value,
          emphasis: 'style2'
        }
      }
      children = []
      if elem.has_elements?
        children = get_rexml_as_tree(elem)
      end
      if elem.text && elem.text.strip != ""
        children << {
          items: [
            text: elem.text.strip,
            emphasis: 'style3'
          ],
          children: []
        }
      end
      tree = {
        items: items,
        children: children
      }
      result << tree
    }
    result
  end
end
