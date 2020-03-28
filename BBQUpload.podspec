
Pod::Spec.new do |spec|
  
  spec.name         = "BBQUpload"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For upload."
  spec.description  = <<-DESC
  BBQUpload是上文件的封装
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/BBQKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/BBQKit.git", :tag => "#{spec.version}" }
  
  spec.vendored_frameworks = 'Framework/BBQUpload/BBQUpload.framework'
  
  spec.dependency 'AFNetworking'
  
  spec.dependency 'BBQSign'
  
  spec.dependency 'BBQOSS'
  
end
