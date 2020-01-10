require_relative '../spaces/model'
require_relative '../container/docker_file_layering'

module Framework
  class Framework < ::Spaces::Model
    include Container::DockerFileLayering

    attr_reader *precedence

    def variables
      %Q(
        ENV CONTFSVolHome /home/fs/
        ENV FRAMEWORK '#{identifier}'
        ENV RUNTIME '#{identifier}'
        ENV PORT '8000'
      )
    end

    def adds
      %Q(
        ADD scripts /scripts
        ADD home home
        ADD spaces home/spaces
        ADD home/start.sh #{start_script_path}
      )
    end

    def final
      %Q(
        USER $ContUser
        CMD ["#{start_script_path}"]
      )
    end

    def start_script_path
      '/home/spaces/scripts/startup/start.sh'
    end

    def identifier
      self.class.identifier
    end
  end
end
