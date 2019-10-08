module OpenAPIOasis::Antipattern::Util
  def extract_params_from_path(path)
    path.scan(/\{((?:[a-z]|[0-9]|[_-])+)\}/i).flatten
  end

  def id_param?(param)
    param.match?(/(?:.+[_-]*[iI](?:d|D|dentifier))$/)
  end

  def resolve_reference(ref_obj, yaml)
    ref = ref_obj['$ref']
    return ref_obj if ref.nil? # Caller does not need to verify if an object is actually a reference.
    raise "At #{ref}: Only local references are supported." unless ref.start_with?('#')

    component_path = ref.split('/')
    raise "At #{ref}: Invalid local reference." if component_path.length < 2
    component_path = component_path[1..-1] # Removes '#' character.
    yaml.dig(*component_path)
  end

  def build_antipattern(offender)
    OpenAPIOasis::Antipattern.new(offender: offender, type: antipattern_type)
  end
end
