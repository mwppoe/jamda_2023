$LOAD_PATH.push File.expand_path('../lib', __FILE__)

# Maintain your wagon's version:
require 'hitobito_jamda_2023/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  # rubocop:disable SingleSpaceBeforeFirstArg
  s.name        = 'hitobito_jamda_2023'
  s.version     = HitobitoJamda2023::VERSION
  s.authors     = ['Manuel Woletz']
  s.email       = ['manuel.woletz@ppoe.at']
  # s.homepage    = 'TODO'
  s.summary     = 'Jamda 2023'
  s.description = 'This hitobito wagon is the registration for the Austrian Contingent'

  s.files = Dir['{app,config,db,lib}/**/*'] + ['Rakefile']
  s.test_files = Dir['test/**/*']
  # rubocop:enable SingleSpaceBeforeFirstArg
end
