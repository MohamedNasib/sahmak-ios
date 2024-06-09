source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
#use_frameworks!
inhibit_all_warnings!

target 'Sahmak' do
  use_frameworks!

  #Networking
  pod 'Moya'
  pod 'Moya-ModelMapper'
  pod 'Nuke'
  pod 'SwiftGradientButton'
  pod 'JNGradientLabel'

#  pod 'Kingfisher'
#  pod 'FacebookCore'
#  pod 'FacebookLogin'
#  pod 'FacebookShare'
#  pod 'GoogleSignIn'
  
  #Maps
  pod 'GoogleMaps'
  pod 'GooglePlaces'
#  pod 'GooglePlacePicker'
  
  #Firebase
  pod 'Firebase'
  pod 'Firebase/Auth'
  pod 'Firebase/Core'
  pod 'Firebase/Database'
  pod 'Firebase/Messaging'
  pod 'Firebase/Analytics'
  pod 'Firebase/Crashlytics'

  #UI
#  pod 'Bagel'
  pod 'SwifterSwift'
  pod 'ARSLineProgress'
  pod 'IQKeyboardManagerSwift'
  pod 'PagedLists'
  pod 'RSSelectionMenu', :git => 'https://github.com/elaimy/RSSelectionMenu.git', :commit => '18f275a5ba59a670fa34aaab0c8d458322857222'
#  pod 'Cosmos'
  pod 'Toaster'
  pod 'MOLH'
#  pod 'UICheckbox.Swift'
#  pod 'SkyFloatingLabelTextField', '~> 3.0'
#  pod 'RangeSeekSlider'
#  pod 'OpalImagePicker', '~> 1.5.0'
#  pod "GMStepper"
  pod 'SKCountryPicker'
  pod 'Mantis'
  pod 'PieCharts'
  pod 'PieChartSwiftUI'
  pod 'SwiftMessages'
  pod 'OnlyPictures'
  pod 'RangeUISlider', '~> 3.0'
  pod 'Charts'

  pod 'ImageSlideshow', '~> 1.9.0'
  pod "ImageSlideshow/Alamofire"

#  pod "ImageSlideshow/Kingfisher"
#  pod "QRCoder"
#  pod 'DLRadioButton'
#  pod 'FSPagerView'
#  pod 'ImageSlideshow'
#  pod "ImageSlideshow/SDWebImage"
  pod 'SwiftValidator', :git => 'https://github.com/jpotts18/SwiftValidator.git'
#  pod 'InteractiveSideMenu'
#  pod 'STTabbar'
#  pod 'MoyasarSdk', git: 'https://github.com/moyasar/moyasar-ios-pod.git'
  pod 'OTPFieldView'
  pod 'AcceptCardSDK'
  

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
    
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['BITCODE_GENERATION_MODE'] = 'bitcode'
            config.build_settings['ENABLE_BITCODE'] = 'YES'
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end
