
Pod::Spec.new do |s|
  s.name             = 'StringSearchKit'
  s.version          = '0.0.1'
  s.summary          = 'A simple framework for macOS - enabling fast, in memory, prefix based, string searching.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: A simple framework that enable fast, in memory, prefix based, string searching using a Trie data strucutre.
                       DESC

  s.homepage         = 'https://github.com/mabidakun/StringSearchKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'mabidakun' => 'github@mikeosoft.co.uk' }
  s.source           = { :git => 'https://github.com/mabidakun/StringSearchKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.osx.deployment_target = '10.11'
  #s.ios.deployment_target = '8.0'
  #s.tvos.deployment_target = '9.0'

  s.source_files = 'StringSearchKit/Classes/**/*'
  
  # s.resource_bundles = {
  #   'StringSearchKit' => ['StringSearchKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
