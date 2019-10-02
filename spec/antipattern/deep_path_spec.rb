require 'spec_helper'

RSpec.describe OpenAPIOasis::Antipattern::DeepPath do
  describe '#detect' do
    context 'three params path' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/deep_path/three_params.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./part_1/{param_1}/part_2/{param_2}/part_3/{param_3}',
                                        type: :deep_path)
        ]

        result = OpenAPIOasis::Antipattern::DeepPath.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'two ID params path' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/deep_path/two_id_params.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./part_1/{param_1_id}/part_2/{param_2_identifier}',
                                        type: :deep_path)
        ]

        result = OpenAPIOasis::Antipattern::DeepPath.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'two regular params path' do
      it 'does not consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/deep_path/two_params.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = []

        result = OpenAPIOasis::Antipattern::DeepPath.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end
  end
end
