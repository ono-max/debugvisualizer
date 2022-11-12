
module DebugVisualizer
  DebugVisualizer.register do |data|
    if (defined?(::ActiveRecord::Base) && data.kind_of?(::ActiveRecord::Base)) ||
       (defined?(::ActiveRecord::Relation) && data.kind_of?(::ActiveRecord::Relation))
      rows = nil
      if data.respond_to? :to_a
        ary = data.to_a
        rows = ary.map{|elem| elem.attributes}
      else
        rows = [data.attributes]
      end

      {
        id: "active_record_visualizer",
        name: "ActiveRecord As Table",
        data: {
          kind: { table: true },
          rows: rows
        }
      }
    end
  end
end
