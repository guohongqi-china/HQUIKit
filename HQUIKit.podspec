#
# Be sure to run `pod lib lint HQUIKit.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HQUIKit'
  s.version          = '0.1.3
  '
  s.summary          = 'iOS UI handle Kit HQUIKit.'


  s.description      = <<-DESC
TODO: iOS UI handle Kit HQUIKit.
                       DESC

  s.homepage         = 'https://github.com/guohongqi-china/HQUIKit'
  # s.screenshots    = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'guohongqi-china' => '820003039@qq.com' }
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
    s.ios.deployment_target = '8.0'

    s.subspec 'UIFramework' do |ss|
      ss.source_files = 'HQUIKit/Classes/UIFramework/**/*.{h,m}'
      ss.public_header_files = 'HQUIKit/Classes/UIFramework/**/*.{h}'
      ss.ios.frameworks = 'MobileCoreServices', 'CoreGraphics'
    end


end
