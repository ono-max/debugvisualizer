module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_as_table",
        name: "Hash As Table",
        priority: 50,
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
        priority: 100,
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
        priority: 20,
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
