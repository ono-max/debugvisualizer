module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Array) && data.all? {|v| v.is_a?(Integer) || v.is_a?(Float) }
      {
        id: "array_as_line_chart",
        name: "Array As Line Chart",
        priority: 100,
        data: {
          "kind":{ "plotly": true },
          "data":[
              { "y": data },
          ]
        }
      }
    end
  end

  DebugVisualizer.register do |data|
    if data.is_a?(Array)
      columns = []
      data.each{|elem|
        columns << {content: elem.to_s}
      }
      new_data = {
        "kind": { "grid": true },
        "rows": [
            {
                "columns": columns
            }
        ]
      }
      {
        id: "array_as_grid",
        name: "Array As Grid",
        priority: 80,
        data: new_data
      }
    end
  end

  DebugVisualizer.register do |data|
    if data.is_a?(Array) && data.all? {|v| v.is_a?(Hash) }
      {
        id: "array_as_table",
        name: "Array As Table",
        priority: 100,
        data: {
          kind: { table: true },
          rows: data
        }
      }
    end
  end

  DebugVisualizer.register do |data|
    if data.is_a?(Array) && data.all? {|v| v.is_a?(Integer) || v.is_a?(Float) }
      {
        id: "array_as_bar_chart",
        name: "Array As Bar Chart",
        priority: 50,
        data: {
          kind: { plotly: true },
          data: [
            {
              y: data,
              type: :bar
            }
          ]
        }
      }
    end
  end

  def self.get_edges(nodes)
    return [] if nodes.size < 3

    edges = []
    prev_id = nodes.first[:id]
    # Get elements except for `First element` and `Last element`
    nodes[1..nodes.size - 2].each{|elem|
      edges << {
        from: prev_id,
        to: elem[:id]
      }
      prev_id = elem[:id]
    }
    edges << {
      from: nodes.last[:id],
      to: prev_id,
      color: 'orange'
    }
    edges
  end

  def self.inspect obj
    obj.inspect
  rescue Exception => e
    "failed to inspect: #{e.message}"
  end

  def self.get_nodes array
    nodes = []
    nodes << {
      id: rand.to_s,
      label: 'First element',
      color: 'orange'
    }
    array.each{|elem| nodes << {id: rand.to_s, label: inspect(elem)}}
    nodes << {
      id: rand.to_s,
      label: 'Last element',
      color: 'orange'
    }
    nodes
  end

  DebugVisualizer.register(Array) do |data|
    nodes = get_nodes(data)
    {
      id: "array_as_graph",
      name: "Array As Graph",
      priority: 90,
      data: {
        kind: { graph: true },
        nodes: nodes,
        edges: get_edges(nodes),
      }
    }
  end
end
