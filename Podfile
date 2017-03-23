platform :ios, '9.0'

project './CorpsPicks/CorpsPicks.xcodeproj'

def myPods
  use_frameworks!
  pod 'SDWebImage'

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

  # Pods for FBSwiftLogin
  pod 'FacebookCore'
  pod 'FacebookLogin'
  pod 'FacebookShare'

  # Firebase
  pod 'Firebase'
  pod 'Firebase/Database'
  pod 'Firebase/Auth'

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
