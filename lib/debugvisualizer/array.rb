module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Array)
      new_data = nil
      name = ""
      if data.all? {|v| v.is_a?(Integer) || v.is_a?(Float) }
        new_data = {
          "kind":{ "plotly": true },
          "data":[
              { "y": data },
          ]
        }
        name = "Array As Plot"
      else
        columns = []
        data.each{|elem|
          columns << {content: elem.to_s, tag: elem.to_s}
        }
        new_data = {
          "kind": { "grid": true },
          "text": "test",
          "columnLabels": [
              {
                  "label": "test"
              }
          ],
          "rows": [
              {
                  "label": "foo",
                  "columns": columns
              }
          ]
        }
        name = "Array As Grid"
      end
      {
        id: "array_visualizer",
        name: name,
        priority: 30,
        data: new_data
      }
    end
  end
end
