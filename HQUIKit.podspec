#
# Be sure to run `pod lib lint HQUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQUIKit'
  s.version          = '0.1.1'
  s.summary          = 'iOS UI handle Kit HQUIKit.'


  s.description      = <<-DESC
TODO: iOS UI handle Kit HQUIKit.
                       DESC

  s.homepage         = 'https://github.com/guohongqi-china/HQUIKit'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guohongqi-china' => 'guohongqi9010@zto.com' }
  s.source           = { :git => 'https://github.com/guohongqi-china/HQUIKit.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HQUIKit/Classes/**/*'

  # s.resource_bundles = {
  #   'HQUIKit' => ['HQUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
