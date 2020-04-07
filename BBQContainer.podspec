Pod::Spec.new do |spec|
  
  spec.name         = "BBQContainer"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For 某些界面."
  spec.description  = <<-DESC
  BBQContainer是欢迎界面
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
    privacy.dependency 'BBQBridge/Protocol/Bridge'
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
  # 设置 setting
  spec.subspec 'Setting' do |setting|
    
    setting.source_files = "Code/BBQContainer/Setting/*.{h,m}"
    setting.dependency 'BBQConfig'
    setting.dependency 'BBQBridge/Setting/Bridge'
    setting.dependency 'Masonry'
    setting.dependency 'BBQTable'
    setting.dependency 'SDWebImage'
  end
  
  # 关于我们 about
  spec.subspec 'About' do |about|
    
    about.source_files = "Code/BBQContainer/About/*.{h,m}"
    about.dependency 'BBQConfig'
    about.dependency 'BBQBridge/About/Bridge'
    about.dependency 'Masonry'
    about.dependency 'BBQTable'
  end
  
  # 意见建议 feedBack
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.source_files = "Code/BBQContainer/FeedBack/*.{h,m}"
    feedBack.dependency 'BBQConfig'
    feedBack.dependency 'BBQBridge/FeedBack/Bridge'
    feedBack.dependency 'Masonry'
    feedBack.dependency 'BBQTransition'
    feedBack.dependency 'JXTAlertManager'
    feedBack.dependency 'BBQTextField'
  end
  
  # 黑名单 black
  spec.subspec 'Black' do |black|
    
    black.source_files = "Code/BBQContainer/Black/*.{h,m}"
    black.dependency 'BBQConfig'
    black.dependency 'BBQBridge/Black/Bridge'
    black.dependency 'Masonry'
    black.dependency 'BBQTable'
    black.dependency 'SDWebImage'
    black.dependency 'JXTAlertManager'
  end
  # 关注 focus
  spec.subspec 'Focus' do |focus|
    
    focus.source_files = "Code/BBQContainer/Focus/*.{h,m}"
    focus.dependency 'BBQConfig'
    focus.dependency 'BBQBridge/Focus/Bridge'
    focus.dependency 'Masonry'
    focus.dependency 'BBQTable'
    focus.dependency 'SDWebImage'
    focus.dependency 'JXTAlertManager'
  end
  
  # 举报 举报
  spec.subspec 'Report' do |report|
    
    report.source_files = "Code/BBQContainer/Report/*.{h,m}"
    report.dependency 'BBQConfig'
    report.dependency 'BBQBridge/Report/Bridge'
    report.dependency 'Masonry'
    report.dependency 'BBQTable'
    report.dependency 'JXTAlertManager'
  end
  
  # 轮播 carousel
  spec.subspec 'Carousel' do |carousel|
    
    carousel.source_files = "Code/BBQContainer/Carousel/*.{h,m}"
    carousel.dependency 'BBQConfig'
    carousel.dependency 'BBQBridge/Carousel/Bridge'
    carousel.dependency 'Masonry'
    carousel.dependency 'BBQCollection'
  end
  # 地址 address
  spec.subspec 'Address' do |address|
    
    address.source_files = "Code/BBQContainer/Address/*.{h,m}"
    address.dependency 'BBQConfig'
    address.dependency 'BBQBridge/Address/Bridge'
    address.dependency 'Masonry'
    address.dependency 'BBQTable'
    address.dependency 'JXTAlertManager'
  end
  # 地址 area
  spec.subspec 'Area' do |area|
    
    area.source_files = "Code/BBQContainer/Area/*.{h,m}"
    area.dependency 'BBQConfig'
    area.dependency 'BBQBridge/Area/Bridge'
    area.dependency 'Masonry'
    area.dependency 'BBQTable'
    area.dependency 'BBQCollection'
    area.dependency 'JXTAlertManager'
  end
  
  # 地址 area
  spec.subspec 'AMapViewOntroller' do |amap|
    amap.vendored_frameworks = 'Framework/BBQAMapViewController/BBQAMapViewController.framework'
    amap.dependency 'BBQTransition'
  end

end
