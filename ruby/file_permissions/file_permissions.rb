require_relative '../installations/collaborator'
require_relative 'file_permission'

module FilePermissions
  class FilePermissions < ::Installations::Collaborator

    Dir["#{__dir__}/scripts/*"].each { |f| require f }
    Dir["#{__dir__}/steps/*"].each { |f| require f }
      
    class << self
      def step_precedence
        @@file_permissions_step_precedence ||= { late: [:run_scripts] }

        def script_lot
          @@file_permission_script_lot ||= [:installation]
        end
      end
    end

    def all
      @all ||= installation.struct.file_permissions.map { |s| file_permission_class.new(struct: s, context: self) }
    end

    def file_permission_class
      FilePermission
    end

  end
end
