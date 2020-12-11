Pod::Spec.new do |s|
  s.name                = 'AituPassportSDK'
  s.version             = '1.1.0'
  s.summary             = 'AituPassport SDK'
  s.description         = <<-DESC
DigitalID SDK
                       DESC
  s.homepage            = 'https://digital-id.kz'
  s.license             = 'MIT'
  s.author              = { 'DigitalID' => 'almas.adilbek@btsdigital.kz' }
  s.source              = { :git => 'https://github.com/btsdigital/aitu-passport-ios-sdk.git', :tag => "v#{s.version}" }
  s.source_files        = 'AituPassportSDK/**/*.{h,m,swift}'
  s.dependency          'Cordova'
  s.dependency          'CordovaRTC'
  s.dependency          'DigitalIDZoomAuthenticationCordovaPlugin', '0.2.7'
  s.ios.deployment_target = '11.0'
  s.swift_version       = '4.2'
end
