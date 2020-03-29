Pod::Spec.new do |spec|
  
  spec.name         = "BBQContainer"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 某些界面."
  spec.description  = <<-DESC
  BBQContainer是欢迎界面
  DESC
  
  spec.homepage     = "https://github.com/StoneStoneStoneWang/ZStoreKit.git"
  spec.license      = { :type => "MIT", :file => "LICENSE.md" }
  spec.author             = { "StoneStoneStoneWang" => "yuanxingfu1314@163.com" }
  spec.platform     = :ios, "10.0"
  spec.ios.deployment_target = "10.0"
  
  spec.swift_version = '5.0'
  
  spec.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  
  spec.static_framework = true
  
  spec.frameworks = 'UIKit', 'Foundation'
  
  spec.source = { :git => "https://github.com/StoneStoneStoneWang/ZStoreKit.git", :tag => "#{spec.version}" }
  
  # 翻译
  spec.subspec 'Welcome' do |welcome|
    
    welcome.source_files = "Code/BBQContainer/Welcome/*.{h,m}"
    welcome.dependency 'BBQConfig'
    welcome.dependency 'BBQBridge/Welcome/Bridge'
    welcome.dependency 'SToolsKit'
    welcome.dependency 'Masonry'
  end
  
end
