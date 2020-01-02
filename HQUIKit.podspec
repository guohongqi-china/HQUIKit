#
# Be sure to run `pod lib lint HQUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQUIKit'
  s.version          = '0.1.0'
  s.summary          = 'iOS UI handle Kit HQUIKit.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

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

  s.source_files = 'HQUIKit/Classes/HQUIKitHeader.h'
  s.public_header_files = 'HQUIKit/Classes/HQUIKitHeader.h'
  
  pch_AF = <<-EOS
#ifndef TARGET_OS_IOS
  #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif

EOS
  s.prefix_header_contents = pch_AF
  
  s.subspec 'UIFramework' do |ss|
    ss.source_files = 'HQUIKit/Classes/UIFramework**/*.{h,m}'
    ss.public_header_files = 'HQUIKit/Classes/UIFramework**/*.{h}'
  end


  # s.resource_bundles = {
  #   'HQUIKit' => ['HQUIKit/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
