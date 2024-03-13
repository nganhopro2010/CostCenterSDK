Pod::Spec.new do |spec|
  spec.name          = 'CostCenterSDK'
  spec.version       = '0.9'
  spec.homepage      = 'https://github.com/nganhopro2010/CostCenterSDK'
  spec.authors      = { 'Ho Van Ngan' => 'nganhopro2010@gmail.com' }
  spec.summary       = 'It is a cost center name xcframework example'
  spec.source        = { :git => 'https://github.com/nganhopro2010/CostCenterSDK.git', :tag => spec.version }
  spec.dependency 'FirebaseCore'
  spec.module_name   = 'CostCenterSDK'
  spec.swift_version = '5.10'
  spec.ios.deployment_target  = '12.0'
  spec.source_files = 'CostCenterSDK/**/*.{h,m, swift}'

end