
Pod::Spec.new do |s|
  s.name             = 'StringSearchKit'
  s.version          = '3.0.0'
  s.summary          = 'A simple library for macOS/iOS/tvOS - enabling fast, in memory, prefix based, string searching, using a Trie.'

  s.description      = <<-DESC
                       A simple library for macOS/iOS/tvOS that enables fast, in memory, prefix based, string searching using a Trie data structure.
                       DESC

  s.homepage         = 'https://github.com/mabidakun/StringSearchKit'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mabidakun' => 'github@mikeosoft.co.uk' }
  s.source           = { :git => 'https://github.com/mabidakun/StringSearchKit.git', :tag => s.version.to_s }

  s.swift_version = '5.9'
  s.osx.deployment_target = '12.0'
  s.ios.deployment_target = '15.0'
  s.tvos.deployment_target = '15.0'

  s.source_files = 'Sources/StringSearchKit/**/*.swift'
end
