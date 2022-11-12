module DebugVisualizer
  DebugVisualizer.register do |data|
    {
      id: "to_string",
      name: "To String",
      priority: 1,
      data: {
        kind: { text: true },
        text: inspect(data),
      }
    }
  end

  def self.inspect obj
    obj.inspect
  rescue Exception => e
    "failed to inspect: #{e.message}"
  end
end
