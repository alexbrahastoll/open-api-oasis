require 'yaml'
require 'open_api_oasis/version'
require 'open_api_oasis/antipattern'
require 'open_api_oasis/antipattern/util'
require 'open_api_oasis/antipattern/deep_path'
require 'open_api_oasis/antipattern/sensitive_info_pqs'

module OpenAPIOasis
  class Error < StandardError; end
end
