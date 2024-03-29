module Tests

  def packing

    group 'CRUD packing' do

      identifier = 'phpmyadmin'
      descriptor = Spaces::Descriptor.new(identifier: identifier)

      test "show #{identifier} pack" do
        output pack = universe.packs.by(identifier)
        output universe.packs.save(pack).to_s
      end

      test "index includes #{identifier}" do
        output identifiers = universe.packs.identifiers
        raise "#{identifier} not created" unless
        identifiers.map(&:to_s).include?(identifier)
      end

      test "build #{identifier}" do
        output pack = universe.packs.by(identifier)
        output universe.packs.commit(pack)
        build = YAML.load_file(universe.workspace.join("Universe", "PackingSpace", identifier, "commit", "output.yaml"))
        output build.stdout
      end

      test 'delete' do
        output pack = universe.packs.by(identifier)
        output universe.packs.delete(pack)
      end

      test 'index after delete' do
        output identifiers = universe.packs.identifiers
        raise "#{identifier} not deleted" if
        identifiers.map(&:to_s).include?(identifier)
      end

    end

  end
end
