module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_as_table",
        name: "Hash As Table",
        data: {
          kind: { table: true },
          rows: data.map{|key, val| {key: key, value: val}}
        }
      }
    end
  end

  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_as_line_graph",
        name: "Hash As Line Chart",
        data: {
          kind: { plotly: true },
          data: [
            {
              x: data.keys,
              y: data.values
            }
          ]
        }
      }
    end
  end
end
