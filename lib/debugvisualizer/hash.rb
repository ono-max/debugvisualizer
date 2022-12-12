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
        id: "hash_as_line_chart",
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

  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_as_pie_chart",
        name: "Hash As Pie Chart",
        data: {
          kind: { plotly: true },
          data: [
            {
              labels: data.keys,
              values: data.values,
              type: :pie
            }
          ]
        }
      }
    end
  end
end
