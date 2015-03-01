Pod::Spec.new do |s|

  s.name             = "ReactiveMantle"
  s.version          = "0.1.0"
  s.summary          = "ReactiveMantle helps you out mapping mantle objects"
  s.homepage         = "https://github.com/bilby91/ReactiveMapping"
  s.license          = 'MIT'
  s.author           = { "Martin Fernandez" => "me@bilby91.com" }
  s.source           = { :git => "https://github.com/bilby91/ReactiveMantle.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/bilby91'

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = 'Pod/Classes/**/*.h'
  s.dependency 'ReactiveCocoa', '~> 2.4'
  s.dependency 'Mantle', '~> 1.5'
end