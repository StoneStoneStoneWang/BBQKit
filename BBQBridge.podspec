Pod::Spec.new do |spec|
  
  spec.name         = "BBQBridge"
  spec.version      = "0.0.1"
  spec.summary      = "A Lib For bridge."
  spec.description  = <<-DESC
  BBQBridge是oc swift 转换的封装呢
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
  
  spec.subspec 'Base' do |base|
    base.source_files = "Code/BBQBridge/Base/*.{swift}"
    base.dependency 'RxSwift'
  end
  
  #欢迎界面
  spec.subspec 'Welcome' do |welcome|
    
    welcome.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Welcome/VM/*.{swift}"
      vm.dependency 'WLToolsKit/Common'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
    end
    
    welcome.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Welcome/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Welcome/VM'
      bridge.dependency 'BBQCollection'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'BBQCocoa/Button'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 协议
  spec.subspec 'Protocol' do |protocol|
    
    protocol.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Protocol/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQSign'
    end
    
    protocol.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Protocol/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Protocol/VM'
      bridge.dependency 'BBQTextInner'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 协议
  spec.subspec 'Privacy' do |privacy|
    
    privacy.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Privacy/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'RxSwift'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQSign'
    end
    
    privacy.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Privacy/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Privacy/VM'
      bridge.dependency 'BBQInner'
      bridge.dependency 'BBQBridge/Base'
      
    end
  end
  
  # 登陆
  spec.subspec 'Login' do |login|
    
    login.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Login/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQCheck'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
    end
    
    login.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Login/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Login/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 注册/登陆
  spec.subspec 'Reg' do |reg|
    
    reg.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Reg/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQCheck'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
    end
    
    reg.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Reg/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Reg/VM'
      bridge.dependency 'BBQCocoa/Button'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 密码
  spec.subspec 'Password' do |password|
    
    password.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Password/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQCheck'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
    end
    
    password.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Password/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Password/VM'
      bridge.dependency 'BBQCocoa/Button'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 设置
  spec.subspec 'Setting' do |setting|
    
    setting.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Setting/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQCache/Account'
      vm.dependency 'BBQSign'
    end
    
    setting.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Setting/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Setting/VM'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 关于我们
  spec.subspec 'About' do |about|
    
    about.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/About/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLToolsKit/String'
    end
    
    about.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/About/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/About/VM'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 昵称
  spec.subspec 'Name' do |name|
    
    name.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Name/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQCache/User'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    name.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Name/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Name/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 个性签名
  spec.subspec 'Signature' do |signature|
    
    signature.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Signature/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQCache/User'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    signature.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Signature/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Signature/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 我的资料
  spec.subspec 'UserInfo' do |userinfo|
    
    userinfo.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/UserInfo/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'BBQCache/User'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
    end
    
    userinfo.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/UserInfo/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/UserInfo/VM'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 评论
  spec.subspec 'Comment' do |comment|
    
    comment.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Comment/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQBean/Comment'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    comment.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Comment/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Comment/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/ASM'
      bridge.dependency 'BBQCocoa/Refresh'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 举报
  spec.subspec 'Report' do |report|
    
    report.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Report/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'ObjectMapper'
      vm.dependency 'RxDataSources'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    report.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Report/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Report/VM'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'RxDataSources'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'BBQHud'
    end
  end
  
  # 黑名单
  spec.subspec 'Black' do |black|
    
    black.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/Black/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQBean/Black'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'WLBaseResult'
    end
    
    black.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Black/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Black/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/ASM'
      bridge.dependency 'BBQCocoa/Refresh'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  # 我的关注
  spec.subspec 'Focus' do |focus|
    
    focus.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Focus/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'BBQBean/Focus'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'WLBaseResult'
    end
    
    focus.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Focus/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Focus/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCocoa/ASM'
      bridge.dependency 'BBQCocoa/Refresh'
      bridge.dependency 'BBQBridge/Base'
    end
  end
  
  # 翻译
  spec.subspec 'Translate' do |translate|
    
    translate.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Translate/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'WLBaseResult'
    end
    
    translate.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Translate/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Translate/VM'
      bridge.dependency 'BBQTransition'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'BBQHud'
    end
  end
  
  spec.subspec 'Area' do |area|
    
    area.subspec 'Manager' do |manager|
      
      manager.source_files = "Code/BBQBridge/Area/Manager/*.{swift}"
      manager.dependency 'RxCocoa'
      manager.dependency 'WLBaseViewModel'
      manager.dependency 'BBQApi'
      manager.dependency 'BBQRReq'
      manager.dependency 'WLBaseResult'
      manager.dependency 'BBQYYCache'
      manager.dependency 'BBQBean/Area'
    end
    area.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Area/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
      vm.dependency 'BBQBean/Area'
    end
    
    area.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Area/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Area/VM'
      bridge.dependency 'BBQBridge/Area/Manager'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCollection'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'BBQCocoa/SM'
    end
  end
  
  spec.subspec 'Address' do |address|
    
    address.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Address/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'ObjectMapper'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'BBQBean/Area'
      vm.dependency 'BBQBean/Address'
      vm.dependency 'WLToolsKit/String'
      
    end
    
    address.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Address/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Address/VM'
      bridge.dependency 'ZTable'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQCocoa/ASM'
      bridge.dependency 'BBQCocoa/SM'
      bridge.dependency 'BBQCocoa/Refresh'
    end
  end
  
  spec.subspec 'Video' do |video|
    
    video.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Video/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    video.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Video/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Video/VM'
      bridge.dependency 'BBQTransition'
      bridge.dependency 'BBQCache/Account'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'BBQHud'
    end
  end
  
  spec.subspec 'Profile' do |profile|
    
    profile.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/Profile/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQCache/User'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    profile.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/Profile/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/Profile/VM'
      bridge.dependency 'BBQTable'
      bridge.dependency 'BBQCache/Account'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'BBQCocoa/SM'
    end
  end
  spec.subspec 'UserCenter' do |userCenter|
    
    userCenter.subspec 'VM' do |vm|
      
      vm.source_files = "Code/BBQBridge/UserCenter/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQApi'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQCache/User'
      vm.dependency 'WLBaseResult'
      vm.dependency 'WLBaseViewModel'
    end
    
    userCenter.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/UserCenter/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/UserCenter/VM'
      bridge.dependency 'BBQCollection'
      bridge.dependency 'BBQCache/Account'
      bridge.dependency 'BBQBridge/Base'
      bridge.dependency 'RxGesture'
      bridge.dependency 'BBQCocoa/SM'
    end
  end
  # 个性签名
  spec.subspec 'FeedBack' do |feedBack|
    
    feedBack.subspec 'VM' do |vm|
      vm.source_files = "Code/BBQBridge/FeedBack/VM/*.{swift}"
      vm.dependency 'RxCocoa'
      vm.dependency 'BBQRReq'
      vm.dependency 'BBQApi'
      vm.dependency 'WLBaseViewModel'
      vm.dependency 'WLBaseResult'
    end
    
    feedBack.subspec 'Bridge' do |bridge|
      bridge.source_files = "Code/BBQBridge/FeedBack/Bridge/*.{swift}"
      bridge.dependency 'BBQBridge/FeedBack/VM'
      bridge.dependency 'BBQHud'
      bridge.dependency 'BBQBase'
      bridge.dependency 'BBQBridge/Base'
    end
  end
end
