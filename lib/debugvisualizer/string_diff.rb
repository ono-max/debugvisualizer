module DebugVisualizer
  DebugVisualizer.register do |data|
    if data.is_a?(Array) && data.size == 2 && data.all? {|elem| elem.is_a?(String)}
      {
        id: "string_diff",
        name: "String diff",
        priority: 50,
        data: {
          kind: { text: true },
          text: data[0],
          otherText: data[1]
        }
      }
    end
  end
end
