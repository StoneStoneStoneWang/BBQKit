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
  
  # 协议 textview
  spec.subspec 'Protocol' do |protocol|
    
    protocol.source_files = "Code/BBQContainer/Protocol/*.{h,m}"
    protocol.dependency 'BBQConfig'
    protocol.dependency 'BBQBridge/Protocol/Bridge'
    protocol.dependency 'SToolsKit'
    protocol.dependency 'Masonry'
  end
  # 协议 webview
  spec.subspec 'Privacy' do |privacy|
    
    privacy.source_files = "Code/BBQContainer/Privacy/*.{h,m}"
    privacy.dependency 'BBQConfig'
    privacy.dependency 'BBQBridge/Privacy/Bridge'
    privacy.dependency 'SToolsKit'
    privacy.dependency 'Masonry'
  end
  # 登陆 login
  spec.subspec 'Login' do |login|
    
    login.source_files = "Code/BBQContainer/Login/*.{h,m}"
    login.dependency 'BBQConfig'
    login.dependency 'BBQBridge/Login/Bridge'
    login.dependency 'Masonry'
    login.dependency 'BBQTextField'
    login.dependency 'BBQTransition'
  end
  
  # 注册 reg
  spec.subspec 'Reg' do |reg|
    
    reg.source_files = "Code/BBQContainer/Reg/*.{h,m}"
    reg.dependency 'BBQConfig'
    reg.dependency 'BBQBridge/Reg/Bridge'
    reg.dependency 'Masonry'
    reg.dependency 'BBQTextField'
    reg.dependency 'BBQTransition'
  end
  
  # 密码 password
  spec.subspec 'Password' do |password|
    
    password.source_files = "Code/BBQContainer/Password/*.{h,m}"
    password.dependency 'BBQConfig'
    password.dependency 'BBQBridge/Password/Bridge'
    password.dependency 'Masonry'
    password.dependency 'BBQTextField'
    password.dependency 'BBQTransition'
  end
  
  # 昵称 Name
  spec.subspec 'Name' do |name|
    
    name.source_files = "Code/BBQContainer/Name/*.{h,m}"
    name.dependency 'BBQConfig'
    name.dependency 'BBQBridge/Name/Bridge'
    name.dependency 'Masonry'
    name.dependency 'BBQTextField'
    name.dependency 'BBQTransition'
  end
  # 个性签名 signature
  spec.subspec 'Signature' do |signature|
    
    signature.source_files = "Code/BBQContainer/Signature/*.{h,m}"
    signature.dependency 'BBQConfig'
    signature.dependency 'BBQBridge/Signature/Bridge'
    signature.dependency 'Masonry'
    signature.dependency 'BBQTransition'
  end
  
  # 个人中心 userinfo
  spec.subspec 'UserInfo' do |userInfo|
    userInfo.frameworks = 'UIKit', 'Foundation','CoreServices'
    userInfo.source_files = "Code/BBQContainer/UserInfo/*.{h,m}"
    userInfo.dependency 'BBQConfig'
    userInfo.dependency 'BBQBridge/UserInfo/Bridge'
    userInfo.dependency 'Masonry'
    userInfo.dependency 'BBQTable'
    userInfo.dependency 'ZDatePicker'
    userInfo.dependency 'SDWebImage'
    userInfo.dependency 'JXTAlertManager'
    userInfo.dependency 'WLToolsKit/Image'
  end
  # 个性签名 signature
  spec.subspec 'Setting' do |setting|
    
    setting.source_files = "Code/BBQContainer/Setting/*.{h,m}"
    setting.dependency 'BBQConfig'
    setting.dependency 'BBQBridge/Setting/Bridge'
    setting.dependency 'Masonry'
    setting.dependency 'BBQTable'
    setting.dependency 'SDWebImage'
  end
  
end
