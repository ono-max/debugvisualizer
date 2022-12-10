module DebugVisualizer
  DebugVisualizer.register do |data|
    if (defined?(Nokogiri::HTML4::Document) && data.kind_of?(Nokogiri::HTML4::Document)) ||
       (defined?(Nokogiri::XML::Document) && data.kind_of?(Nokogiri::XML::Document))
      {
        id: "nokogiri_visualizer",
        name: "Nokogiri As Tree",
        data: {
          kind: { tree: true },
          root: get_tree(data.children).last
        }
      }
    end
  end

  def self.get_tree(elems)
    result = []
    elems.each{|elem|
      child = []
      elem.attributes.each{|key, val|
        items = []
        items << {
          text: "#{key}: ",
          emphasis: 'style2'
        }
        items << {
          text: val.value,
          emphasis: 'style2'
        }
        child << {
         items: items, 
         children: []
        }
      }
      if elem.children
        child.push *get_tree(elem.children)
      end
      next if elem.name == 'text'

      tree = {
        items: [
          {
            text: elem.name,
            emphasis: 'style1'
          }          
        ],
        children: child
      }
      text = elem.xpath('text()').text
      if text && text.strip != ""
        tree[:items] << {
          text: ' ' * 2 + text.strip
        }
      end
      result << tree
    }
    result
  end
end
