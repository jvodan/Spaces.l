require_relative '../releases/collaborator'

module Users
  class User < ::Releases::Collaborator

    class << self
      def inheritance_paths; __dir__ ;end
    end

    require_files_in :steps, :scripts

    def identifier
      struct.identifier
    end

    def default
      @default ||= OpenStruct.new(data_uid: '2222', data_gid: '3333')
    end

  end
end
