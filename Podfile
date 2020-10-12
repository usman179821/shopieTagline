# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'shopie_Driver' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

   # Pods for shopie

  pod 'Alamofire'
  pod 'SwiftyJSON'  
  pod "TextFieldEffects"
  pod 'IQKeyboardManagerSwift'
  pod 'SDWebImage', '~> 4.0'
  pod 'SwiftMessages'
  pod 'Toast-Swift', '~> 4.0.0'
  pod 'UITextView+Placeholder'
  pod 'FBSDKLoginKit'
  pod 'GoogleSignIn'
    
  
  
  
end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings.delete('CODE_SIGNING_ALLOWED')
    config.build_settings.delete('CODE_SIGNING_REQUIRED')
  end
end
