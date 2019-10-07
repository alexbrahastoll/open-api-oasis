RSpec.describe OpenAPIOasis::Antipattern::SensitiveInfoPQS do
  describe '#detect' do
    context 'when a path param seems to hold sensitive info' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/sensitive_info_pqs/sensitive_in_path.yml'
        yaml = YAML.load(File.read(yaml_path))
        # There are two endpoints using different verbs, but the same path.
        # Therefore, two detections will occur.
        # TODO: Add the verb to an Antipattern object?
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./customers/{customer_token}?customer_token',
                                        type: :sensitive_info_pqs),
          OpenAPIOasis::Antipattern.new(offender: 'paths./customers/{customer_token}?customer_token',
                                        type: :sensitive_info_pqs)
        ]

        result = OpenAPIOasis::Antipattern::SensitiveInfoPQS.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'when a query string param seems to hold sensitive info' do
      it 'does consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/sensitive_info_pqs/sensitive_in_query_string.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = [
          OpenAPIOasis::Antipattern.new(offender: 'paths./customers?customer_token',
                                        type: :sensitive_info_pqs)
        ]

        result = OpenAPIOasis::Antipattern::SensitiveInfoPQS.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end

    context 'when no params seem to hold sensitive info' do
      it 'does not consider it to be an antipattern' do
        yaml_path = 'spec/fixtures/antipattern/no_antipatterns.yml'
        yaml = YAML.load(File.read(yaml_path))
        expected_result = []

        result = OpenAPIOasis::Antipattern::SensitiveInfoPQS.detect(yaml)

        expect(result).to match_array(expected_result)
      end
    end
  end
end
