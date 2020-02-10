require_relative '../products/product'
require_relative '../docker/files/collaboration'

module Nodules
  class Nodules < ::Products::Product
    include Docker::Files::Collaboration

    Dir["#{__dir__}/steps/*"].each { |f| require f }

    class << self
      def step_precedence
        @@nodules_step_precedence ||= { late: [:run_scripts] }
      end
    end

    def all
      @all ||= tensor.struct.modules.map { |s| universe.nodules.by(struct: s, context: self) }
    end

    def scripts
      all.map { |s| s.scripts }
    end

    def image_space_path
       'modules'
    end

  end
end
