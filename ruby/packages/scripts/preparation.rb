require_relative '../../texts/one_time_script'

module Packages
  module Scripts
    class Preparation < Texts::OneTimeScript

      relation_accessor :package

      def body
        %Q(
        mkdir /#{build_script_path}
        cd /#{build_script_path}
        )
      end

    end
  end
end
