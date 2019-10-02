module OpenAPIOasis::Antipattern::Util
  def extract_params_from_path(path)
    path.scan(/\{((?:[a-z]|[0-9]|[_-])+)\}/i).flatten
  end

  def id_param?(param)
    param.match?(/(?:.+[_-]*[iI](?:d|D|dentifier))$/)
  end

  def build_antipattern(offender)
    OpenAPIOasis::Antipattern.new(offender: offender, type: antipattern_type)
  end
end
