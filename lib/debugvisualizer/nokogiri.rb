module DebugVisualizer
  DebugVisualizer.register do |data|
    if (defined?(Nokogiri::HTML4::Document) && data.kind_of?(Nokogiri::HTML4::Document)) ||
       (defined?(Nokogiri::XML::Document) && data.kind_of?(Nokogiri::XML::Document))
      {
        id: "nokogiri_visualizer",
        name: "Nokogiri As Tree",
        data: {
          kind: { tree: true },
          root: get_nokogiri_as_tree(data.children).last
        }
      }
    end
  end

  def self.get_nokogiri_as_tree(elems)
    result = []
    elems.each{|elem|
      items = [
        {
          text: elem.name,
          emphasis: 'style1'
        }          
      ]
      elem.attributes.each{|key, val|
        items << {
          text: "  #{key} =",
        }
        items << {
          text: "\"#{val.value}\"",
          emphasis: 'style2'
        }
      }
      child = []
      if elem.children
        child = get_nokogiri_as_tree(elem.children)
      end
      next if elem.name == 'text'

      text = elem.xpath('text()').text
      if text && text.strip != ""
        child << {
          items: [
            text: text.strip,
            emphasis: 'style3'
          ],
          children: []
        }
      end

      tree = {
        items: items,
        children: child
      }
      result << tree
    }
    result
  end
end
