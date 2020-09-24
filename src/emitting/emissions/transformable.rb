require_relative 'stanzas'

module Emissions
  class Transformable < ::Spaces::Model
    include Stanzas

    class << self
      def stanza_lot
        files_in(:stanzas).map { |f| ::File.basename(f, '.rb') }
      end

      def inheritance_paths; __dir__ ;end
    end

    require_files_in :stanzas

    delegate(mandatory_keys: :composition)

    def declaratives
      stanzas.map(&:declaratives)
    end

  end
end
