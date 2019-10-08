RSpec.describe OpenAPIOasis::Antipattern::SequentialID do
  describe '#detect' do
    context 'sequential ID in the path' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/sequential_id/in_path.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./some_resource/{resource_id}?resource_id',
                                        type: :sequential_id)
        ]

        result = OpenAPIOasis::Antipattern::SequentialID.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'sequential ID in the query string' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/sequential_id/in_query_string.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./some_resource?resource_id',
                                        type: :sequential_id)
        ]

        result = OpenAPIOasis::Antipattern::SequentialID.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'sequential ID in a parameter defined via a $ref' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/sequential_id/defined_via_ref.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./some_resource/{resource_id}?resource_id',
                                        type: :sequential_id)
        ]

        result = OpenAPIOasis::Antipattern::SequentialID.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'no sequential ID' do
      it 'does return an empty array' do
        yaml_path = 'spec/fixtures/antipattern/no_antipatterns.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = []

        result = OpenAPIOasis::Antipattern::SequentialID.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end
  end
end
