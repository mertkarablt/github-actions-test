# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
#source 'https://github.com/CocoaPods/Specs.git'

# Disables the usage of input/output files,
# because its broken in the new build system: https://openradar.appspot.com/41126633.
install! 'cocoapods', :disable_input_output_paths => true
install! 'cocoapods', :warn_for_unused_master_specs_repo => false

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings['LD_RUNPATH_SEARCH_PATHS'] = [
    '$(FRAMEWORK_SEARCH_PATHS)'
    ]
  end
  
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |build_conf|
      build_conf.build_settings['CODE_SIGN_IDENTITY'] = ""
      build_conf.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      build_conf.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = '$(inherited)'
    end
  end
end

project 'github-actions-test.xcodeproj'

target 'github-actions-test' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for github-actions-test

  pod 'SwiftLint'
  pod 'FLEX', :configurations => ['Dev', 'Beta']
  pod 'SwiftGen'

  pod 'Firebase/Analytics'
  pod 'Firebase/DynamicLinks'
  pod 'Firebase/Crashlytics'
  pod 'Firebase/Messaging'
  pod 'Firebase/Performance'

  pod 'Alamofire'
  pod 'Kingfisher'

  pod 'IQKeyboardManagerSwift'
  pod 'Localize-Swift'
  pod 'DeepLinkKit'
  pod 'lottie-ios'


  target 'github-actions-testTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'github-actions-testUITests' do
    # Pods for testing
  end

end
