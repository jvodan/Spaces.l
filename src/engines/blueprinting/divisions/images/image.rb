module Divisions
  class Image < ::Emissions::Subdivision

    class << self
      def constant_for(type)
        Module.const_get("::Providers::#{type.to_s.camelize}::Image")
      end
    end

    delegate(tenant: :emission)

    def identifier; type ;end

    def name; struct.name || defaults[:name] ;end
    def output_image; struct.output_image || defaults[:output_image] ;end

    def default_tag; 'latest' ;end

    def export; struct ;end
    def commit; struct ;end

    def complete?
      !(type && image).nil?
    end

    def post_processor_stanzas; end

  end
end
