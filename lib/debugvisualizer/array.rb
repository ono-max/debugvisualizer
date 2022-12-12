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
        priority: 30,
        data: new_data
      }
    end
  end
end
