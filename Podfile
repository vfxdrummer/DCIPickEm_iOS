platform :ios, '9.0'

project './CorpsPicks/CorpsPicks.xcodeproj'

def myPods
  use_frameworks!
  pod 'SDWebImage'

  # activity indicator
  pod 'NVActivityIndicatorView'

  # M13 checkbox
  pod 'M13Checkbox'  
  
  # JSON / Networking
  source 'https://github.com/CocoaPods/Specs.git'
  use_frameworks!
#  pod 'Alamofire'
#  pod 'SwiftyJSON', :git => 'https://github.com/SwiftyJSON/SwiftyJSON.git'
  use_frameworks!
#  pod 'ReachabilitySwift', :git => 'https://github.com/ashleymills/Reachability.swift'

  # Answers / Crashlytics
  pod 'Fabric'
  pod 'Crashlytics'

  # FB SDK
#  pod 'FBSDKLoginKit'

  # Firebase UI
  pod 'FirebaseUI/Database'  
  pod 'FirebaseUI/Auth'
  pod 'FirebaseUI/Google'
  pod 'FirebaseUI/Facebook'
#  pod 'FirebaseUI/Twitter'

  # Firebase
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Database'

end

target 'CorpsPicks' do
  myPods
end
target 'CorpsPicksTests' do
  myPods
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['ENABLE_BITCODE'] = 'NO'
    end
  end
end
