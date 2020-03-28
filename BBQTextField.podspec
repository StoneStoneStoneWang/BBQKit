Pod::Spec.new do |spec|
  
  spec.name         = "BBQTextField"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For textfield."
  spec.description  = <<-DESC
  BBQTextField是地图
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
  
  spec.subspec 'Setting' do |setting|
    setting.source_files = "Code/BBQTextField/Setting/*.{swift}"
  end
  spec.subspec 'Base' do |base|
    base.source_files = "Code/BBQTextField/Base/*.{swift}"
    base.dependency 'WLToolsKit/Then'
    base.dependency 'BBQTextField/Setting'
  end
  
  spec.subspec 'LeftTitle' do |leftTitle|
    leftTitle.source_files = "Code/BBQTextField/LeftTitle/*.{swift}"
    leftTitle.dependency 'BBQTextField/Base'
    leftTitle.dependency 'WLToolsKit/Color'
  end
  spec.subspec 'LeftImage' do |leftImage|
    leftImage.source_files = "Code/BBQTextField/LeftImg/*.{swift}"
    leftImage.dependency 'BBQTextField/Base'
  end
  spec.subspec 'NickName' do |nickName|
    nickName.source_files = "Code/BBQTextField/NickName/*.{swift}"
    nickName.dependency 'BBQTextField/Base'
  end
  
  spec.subspec 'Password' do |password|
    password.source_files = "Code/BBQTextField/Password/*.{swift}"
    password.dependency 'BBQTextField/LeftImage'
    password.dependency 'BBQTextField/LeftTitle'
  end
  
  spec.subspec 'Vcode' do |vcode|
    vcode.source_files = "Code/BBQTextField/Vcode/*.{swift}"
    vcode.dependency 'BBQTextField/LeftImage'
    vcode.dependency 'BBQTextField/LeftTitle'
  end
  spec.subspec 'Login' do |vcode|
    vcode.source_files = "Code/BBQTextField/Login/*.{swift}"
    vcode.dependency 'BBQTextField/LeftImage'
    vcode.dependency 'BBQTextField/LeftTitle'
  end
  
end
