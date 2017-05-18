#
# Be sure to run `pod lib lint ZCWView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZCWView'
  s.version          = '0.0.1'
  s.summary          = 'Some view'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/zhaochangwu/ZCWView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zhaochangwu' => 'changwuzhao@cienet.com.cn' }
  s.source           = { :git => 'https://github.com/zhaochangwu/ZCWView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'ZCWView/Classes/**/*'

  # s.resource_bundles = {
  #   'ZCWView' => ['ZCWView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'ZCWTool'
  s.dependency 'Masonry', '~> 1.0.1'
  s.prefix_header_contents = '#import <ZCWTool/ZCWTool.h>', '#import <UIKit/UIKit.h>', '#import <Foundation/Foundation.h>', '#import "Masonry.h"'
end
