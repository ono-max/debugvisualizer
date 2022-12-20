# frozen_string_literal: true

require 'securerandom'
require 'json'

module DebugVisualizer
  def register klass = nil, &block
    raise unless block_given?

    unless defined? GENERATOR
      DebugVisualizer.const_set(:GENERATOR, JSONGenerator.new)
    end

    if klass
      GENERATOR.register_block_with_class klass, block
    else
      GENERATOR.register_block block
    end
  end

  def to_debug_visualizer_protocol_json preferred_id, data
    json = GENERATOR.generate preferred_id, data
    if defined? ::DEBUGGER__::NaiveString
      ::DEBUGGER__::NaiveString.new(json)
    else
      json
    end
  end

  module_function :register, :to_debug_visualizer_protocol_json

  class JSONGenerator
    attr_accessor :default_registered

    def initialize
      @blocks = []
      @block_with_class = {}
    end

    def register_block block
      @blocks << block
    end

    def register_block_with_class klass, block
      @block_with_class[klass] = block
    end

    def generate preferred_id, data
      extractors = []
      @blocks.each{|block|
        result = block.call(data)
        if result && result[:id] && result[:data]
          extractors << get_extractor(result)
        end
      }

      @block_with_class.each{|klass, block|
        if data.kind_of? klass
          result = block.call(data)
          if result && result[:id] && result[:data]
            extractors << get_extractor(result)
          end
        end
      }

      return JSON.generate({ kind: "NoExtractors" }) if extractors.empty?

      sorted = extractors.sort_by{|ex| -ex[:priority]}
      used_ex = sorted[0]

      unless preferred_id.empty?
        sorted.each{|ex|
          if ex[:id] == preferred_id
            used_ex = ex
            break
          end
        }
      end
      

      data = used_ex.delete(:data)

      sorted.each{|ex| ex.delete :data}

      JSON.generate({
        kind: "Data",
        extractionResult: {
          data: data,
          usedExtractor: used_ex,
          availableExtractors: sorted,
        },
      })
    rescue Exception => e
      JSON.generate({
        kind: "Error",
        message: e.message
      })
    end

    private

    def get_extractor result
      {
        id: result[:id],
        name: result[:name] || result[:id],
        priority: result[:priority] || 100,
        data: result[:data]
      }
    end
  end
end

require_relative 'debugvisualizer/active_record'
require_relative 'debugvisualizer/array'
require_relative 'debugvisualizer/hash'
require_relative 'debugvisualizer/to_string'
require_relative 'debugvisualizer/string_diff'
require_relative 'debugvisualizer/rexml'
require_relative 'debugvisualizer/nokogiri'
require_relative 'debugvisualizer/rubyvm_ast'
