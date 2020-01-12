require_relative 'docker_file_layering'

module Container
  class Need < ::Spaces::Model
    include DockerFileLayering

    relation_accessor :tensor

    attr_reader *precedence

    def variables
      resolution.keys.map do |k|
        "ENV #{k} '#{resolution[k]}'"
      end
    end

    def resolution
      @resolution ||= needed_tensor.resolution_for(tensor.overrides_for(struct.variables))
    end

    def needed_tensor
      tensor.dependencies.detect { |d| d.struct.descriptor.value == struct.descriptor.value }
    end

    def initialize(struct, tensor)
      self.struct = struct
      self.tensor = tensor
    end

  end
end