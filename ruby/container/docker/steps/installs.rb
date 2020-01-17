require_relative 'requires'

module Container
  module Docker
    class Installs < Step

      def content
        %Q(
          WORKDIR /home/
          RUN \
            bash /home/setup.sh
        )
      end

    end
  end
end
