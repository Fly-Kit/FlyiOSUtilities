#
#  Be sure to run `pod spec lint FlyiOSUtilities.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "FlyiOSUtilities"
  s.version      = "0.0.1"
  s.license      = "MIT"
  s.summary      = "iOS相关工具"
  s.homepage     = "https://github.com/Fly-Kit/FlyiOSUtilities"
  # s.social_media_url   = "http://twitter.com/fly1324928301"
  s.author             = { "fly1324928301" => "1324928301@qq.com" }
  s.source       = { :git => "git@github.com:Fly-Kit/FlyiOSUtilities.git", :tag => s.version}
  s.requires_arc = true
  s.source_files  = "FlyiOSUtilities/**/*"

  s.platform     = :ios, "8.0"
  s.ios.deployment_target = "8.0"

  s.framework  = "Foundation", "UIKit", "CoreGraphics"

  

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

end
