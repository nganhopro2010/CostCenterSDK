Pod::Spec.new do |spec|
  spec.name          = 'CostCenterSDK'
  spec.version       = '1.4'
  spec.license        = { :type => 'MIT', :file => './LICENSE.txt' }
  spec.homepage      = 'https://github.com/nganhopro2010/CostCenterSDK'
  spec.authors      = { 'Ho Van Ngan' => 'nganhopro2010@gmail.com' }
  spec.summary       = 'It is a cost center name xcframework example'
  spec.source        = { :git => 'https://github.com/nganhopro2010/CostCenterSDK.git', :tag => spec.version }
  spec.dependency 'FirebaseCore'
  spec.dependency 'Firebase/Installations'
  spec.module_name   = 'CostCenterSDK'
  spec.swift_version = '5.10'
  spec.ios.deployment_target  = '12.0'
  spec.source_files = 'CostCenterSDK/**/*.swift'


end