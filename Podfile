# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'bookin' do
  use_frameworks!

  pod 'RxSwift', '~> 3.0'
  pod 'RxCocoa', '~> 3.0'
  pod 'RxDataSources', '~> 1.0'
  pod 'RxGesture'
  pod 'RxOptional'
  pod 'RxRealm'

  pod 'Realm'
  pod 'RealmSwift'
  pod 'SnapKit', '~> 3.0'
  pod 'FileKit', '~> 4.0.0'
  pod 'ChameleonFramework/Swift', :git => 'https://github.com/ViccAlexander/Chameleon.git'

  target 'bookinTests' do
    inherit! :search_paths

    pod 'RxBlocking', '~> 3.0'
    pod 'RxTest',     '~> 3.0'
  end

end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '3.0'
		end
	end
end
