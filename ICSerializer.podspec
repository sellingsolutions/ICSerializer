
Pod::Spec.new do |s|
  s.name             = 'ICSerializer'
  s.version          = '1.0.1'
  s.summary          = 'A serializer that will do deep clones of infinitely nested json graphs.'

  s.description      = <<-DESC
A serializer that will do deep clones of infinitely nested json graphs. Much like the latest version of Codable in Swift 4, you don't have to write any boiler plate code for ICSerializer to serialize/deserialize your objects. Just make your classes inherit from ICSerializable and you're done
                       DESC

  s.homepage         = 'https://icontrolapp.se/en'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'sellingsolutions' => 'alexander@icontrolapp.se' }
  s.source           = { :git => 'https://github.com/sellingsolutions/ICSerializer.git', :tag => '1.0.1' }

  s.social_media_url = 'https://twitter.com/zno85'

  s.swift_version = '4.0'
  s.ios.deployment_target = '10.0'
  s.requires_arc = true

  s.source_files = 'ICSerializer/Classes/**/*.swift'
  s.frameworks = 'Foundation'
end
