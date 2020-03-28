
Pod::Spec.new do |spec|
  
  spec.name         = "BBQTransition"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For transition."
  spec.description  = <<-DESC
  BBQTransition是转场的封装
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
  
  spec.vendored_frameworks = 'Framework/BBQTransition/BBQTransition.framework'
  
  spec.dependency 'BBQBase'
  spec.dependency 'BBQNavi'
  spec.dependency 'SToolsKit'
  
end
