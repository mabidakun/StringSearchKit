
Pod::Spec.new do |s|
  s.name             = 'StringSearchKit'
  s.version          = '0.0.7'
  s.summary          = 'A simple library for macOS/iOS/tvOS - enabling fast, in memory, prefix based, string searching, using a Trie.'

  s.description      = <<-DESC
                       A simple library for macOS/iOS/tvOS that enables fast, in memory, prefix based, string searching using a Trie data strucutre.
                       DESC

  s.homepage         = 'https://github.com/mabidakun/StringSearchKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mabidakun' => 'github@mikeosoft.co.uk' }
  s.source           = { :git => 'https://github.com/mabidakun/StringSearchKit.git', :tag => s.version.to_s }

  s.osx.deployment_target = '10.11'
  s.ios.deployment_target = '8.0'
  s.tvos.deployment_target = '9.0'

  s.source_files = 'StringSearchKit/Classes/**/*'
end
