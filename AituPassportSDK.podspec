Pod::Spec.new do |s|
  s.name                = 'AituPassportSDK'
  s.version             = '1.2.3'
  s.summary             = 'AituPassport SDK'
  s.description         = <<-DESC
Aitu Passport SDK
                       DESC
  s.homepage            = 'https://passport.aitu.io'
  s.license             = 'MIT'
  s.author              = { 'DigitalID' => 'almas.adilbek@btsdigital.kz' }
  s.source              = { :git => 'https://github.com/btsdigital/aitu-passport-ios-sdk.git', :tag => "v#{s.version}" }
  s.source_files        = 'AituPassportSDK/**/*.{h,m,swift}'
  s.dependency          'Cordova'
  s.dependency          'CordovaRTC'
  s.dependency          'DigitalIDZoomAuthenticationCordovaPlugin', '~> 0.2.0'
  s.ios.deployment_target = '11.0'
  s.swift_version         = '5.0'
  s.user_target_xcconfig  = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.pod_target_xcconfig   = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
