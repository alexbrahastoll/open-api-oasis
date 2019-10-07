class OpenAPIOasis::Antipattern::SensitiveInfoPQS
  include OpenAPIOasis::Antipattern::Util

  SENSITIVE_NAMES_LIST = ['secret', 'password', 'pwd', 'token', 'session'].freeze

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
    :sensitive_info_pqs
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
      check_sensitive(param)
    end
  end

  def check_sensitive(param)
    return unless ['path', 'query'].include?(param['in'])

    sensitive = false
    SENSITIVE_NAMES_LIST.each do |sensitive_name|
      sensitive = param['name'].include?(sensitive_name)
      break if sensitive
    end

    sensitive ? build_antipattern(offender(param)) : nil
  end

  def offender(param)
    "paths.#{current_path}?#{param['name']}"
  end
end
