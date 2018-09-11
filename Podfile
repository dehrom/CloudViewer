# Uncomment the next line to define a global platform for your project
 platform :osx, '10.14'

target 'CloudViewer' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  inhibit_all_warnings!

  # Pods for CloudViewer
    pod 'SnapKit'
    pod 'Result', '~> 3.0'
    pod 'RxSwift'
    pod 'RxCocoa'
    pod 'GoogleAPIClientForREST/Sheets', '~> 1.2.1'
    pod 'GTMAppAuth'
    
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                if !['RxSwift', 'RxCocoa'].include? target.name
                    config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.14'
                end
            end
            if ['RxCocoa'].include? target.name
                target.build_configurations.each do |config|
                    config.build_settings['SWIFT_VERSION'] = '4.0'
                end
            end
        end
    end
end
