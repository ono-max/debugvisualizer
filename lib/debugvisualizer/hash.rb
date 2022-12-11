module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_visualizer",
        name: "Hash As Table",
        data: {
          kind: { table: true },
          rows: data.map{|key, val| {key: key, value: val}}
        }
      }
    end
  end
end
