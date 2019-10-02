class OpenAPIOasis::Antipattern::DeepPath
  include OpenAPIOasis::Antipattern::Util

  attr_reader :yaml

  def self.detect(yaml)
    new(yaml).detect_antipattern
  end

  def detect_antipattern
    paths.map { |p| maybe_antipattern(p) }.compact
  end

  private

  def initialize(yaml)
    @yaml = yaml
  end

  def antipattern_type
    :deep_path
  end

  def paths
    yaml['paths'].keys
  end

  def maybe_antipattern(path)
    params = extract_params_from_path(path)
    return nil if params.length < 2

    if params.length > 2
      build_antipattern(offender(path))
    else # the path has exactly 2 params
      params.all? { |p| id_param?(p) } ? build_antipattern(offender(path)) : nil
    end
  end

  def offender(path)
    "paths.#{path}"
  end
end
