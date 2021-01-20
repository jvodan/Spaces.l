module Publishing
  class Space < Git::Space

    class << self
      def default_model_class
        Blueprint
      end
    end

    delegate(blueprints: :universe)

    alias_method :by, :by_json
    alias_method :save, :save_json
    alias_method :imported?, :exist?

    def import(descriptor, force: false)
      delete(descriptor) if force && imported?(descriptor)

      if imported?(descriptor)
        by(descriptor.identifier)
      else
        super(descriptor)
        by(descriptor.identifier).tap do |m|
          blueprints.import(m, descriptor, force: force)
          import_targets_for(m)
        end
      end
    rescue Errno::ENOENT => e
      warn(error: e, descriptor: descriptor, verbosity: [:error])
    end

    def import_targets_for(model)
      unimported_blueprints_for(model, :bindings).each { |d| import(d) }
    end

    def unimported_blueprints_for(model, division_identifier)
      model.descriptors_for(division_identifier).reject { |d| imported?(d) }
    end

  end
end
