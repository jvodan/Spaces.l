require_relative '../../spaces/model'
require_relative '../../docker/files/collaboration'
require_relative 'dependent'

module Blueprints
  class Dependencies < ::Spaces::Model
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    relation_accessor :tensor

    def layers_for(group)
      all.map { |a| a.layers_for(group) }
    end

    def all
      @all ||= tensor.struct.dependencies.map { |d| dependent_class.new(d, tensor) } || []
    end

    def dependent_class
      Dependent
    end

    def initialize(tensor)
      self.tensor = tensor
    end

  end
end
