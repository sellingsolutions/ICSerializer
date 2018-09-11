#
# Be sure to run `pod lib lint ICSerializer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ICSerializer'
  s.version          = '0.1.0'
  s.summary          = 'A serializer that will do deep clones of infinitely nested json graphs.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A serializer that will do deep clones of infinitely nested json graphs. Much like the latest version of Codable in Swift 4, you don't have to write any boiler plate code for ICSerializer to serialize/deserialize your objects. Just make your classes inherit from ICSerializable and you're done
                       DESC

  s.homepage         = 'https://icontrolapp.se/en'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sellingsolutions' => 'alexander@icontrolapp.se' }
  s.source           = { :git => 'https://github.com/sellingsolutions/ICSerializer.git', :tag => s.version.to_s }

  s.social_media_url = 'https://twitter.com/zno85'

  s.swift_version = '4.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  s.source_files = 'ICSerializer/Classes/**/*.swift'
  s.frameworks = 'Foundation'
end
