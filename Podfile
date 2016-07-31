source 'https://github.com/CocoaPods/Specs.git'

# Utilities
pod 'PromiseKit'

# Extensions
pod 'EZSwiftExtensions' # extensions

# Networking
pod 'Alamofire', '~> 3.0'
pod 'SwiftyJSON' # json parser
pod 'ReachabilitySwift' # reachability check - extension of alamofire

pod 'PokemonKit'

# Core Data
pod 'MagicalRecord/Shorthand'

# UI / Controllers / Views
pod 'pop', '~> 1.0' # Custom animations
pod 'IQKeyboardManagerSwift' # Keyboard accessory
pod 'SVProgressHUD' # Progress Circle

#debugging
pod 'SwiftyBeaver'

# Analytics
pod 'Analytics'
pod 'Segment-GoogleAnalytics'

pod 'Fabric'
pod 'Crashlytics'

pod 'AlamofireImage', '~> 2.0'

# swift integration
use_frameworks!

# who cares about warnings
inhibit_all_warnings!

#CI
pod 'BuddyBuildSDK'

# this noops the method at runtime
Pod::Installer.class_eval { def verify_no_static_framework_transitive_dependencies; end }

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            if config.build_settings['PRODUCT_NAME'] == "Segment_GoogleAnalytics"
                config.build_settings['LIBRARY_SEARCH_PATHS'] = ["$(inherited)", "$(PODS_ROOT)/GoogleAnalytics/Libraries", "$(PODS_ROOT)/GoogleIDFASupport/Libraries"]
                config.build_settings['OTHER_LDFLAGS'] = %Q{-weak_framework "CoreData" -weak_framework "SystemConfiguration" -l"z" -l"sqlite3" -l"sqlite3.0" -l"GoogleAnalytics"}
            end
        end
    end
end