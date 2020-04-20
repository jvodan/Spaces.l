require_relative '../../docker/files/step'

module Images
  module Steps
    class ChownAppDir < Docker::Files::Step
      def product
        "RUN /#{context.product_path}/chown_app_dir.sh"
      end

    end
  end
end