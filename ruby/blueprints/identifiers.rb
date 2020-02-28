require_relative '../collaborators/collaborator'

module Blueprints
  class Identifiers < ::Collaborators::Collaborator

    def initialize(tensor)
      super
      self.struct = OpenStruct.new(data_uid: '2222', data_gid: '3333', group_uid: '4444', cont_user_id: '5555')
    end

  end
end
