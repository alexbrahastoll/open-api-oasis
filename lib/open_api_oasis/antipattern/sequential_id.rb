class OpenAPIOasis::Antipattern::SequentialID
  include OpenAPIOasis::Antipattern::Util

  attr_reader :yaml, :current_path

  def self.detect(yaml)
    new(yaml).detect_antipattern
  end

  def detect_antipattern
    paths.map do |path, metadata|
      @current_path = path
      maybe_antipattern(path, metadata)
    end.flatten.compact
  end

  private

  def initialize(yaml)
    @yaml = yaml
  end

  def antipattern_type
    :sequential_id
  end

  def paths
    yaml['paths']
  end

  def parameters(path_verb)
    path_verb['parameters'] || []
  end

  def maybe_antipattern(path, metadata)
    metadata.map { |verb, meta| process_verb(verb, meta) }
  end

  def process_verb(verb, metadata)
    parameters(metadata).map do |param|
      detect_sequential_id(param)
    end
  end

  def detect_sequential_id(resolvable_param)
    param = resolve_reference(resolvable_param, yaml)
    return unless ['path', 'query'].include?(param['in'])
    return unless id_param?(param['name'])

    param.dig('schema', 'type') == 'integer' ? build_antipattern(offender(param)) : nil
  end

  def offender(param)
    "paths.#{current_path}?#{param['name']}"
  end
end
