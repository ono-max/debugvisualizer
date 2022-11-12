module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Hash)
      {
        id: "hash_visualizer",
        name: "Hash As Table",
        data: {
          kind: { table: true },
          rows: [data]
        }
      }
    end
  end
end
