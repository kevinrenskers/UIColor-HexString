Pod::Spec.new do |s|
  s.name         = "UIColor-HexString"
  s.version      = "2.0.0"
  s.summary      = "Easy, Android-compatible hex strings to UIColor."
  s.homepage     = "https://github.com/kevinrenskers/UIColor-HexString"
  s.license      = { :type => 'BSD', :file => 'LICENSE' }
  s.author       = { "Kevin Renskers" => "info@mixedcase.nl" }
  s.ios.deployment_target = '6.0'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'
  s.source       = { :git => "https://github.com/kevinrenskers/UIColor-HexString.git", :tag => s.version.to_s }
  s.source_files = '*.{h,m}'
  s.requires_arc = true
  s.header_dir   = 'UIColor_HexString'
  s.module_name  = 'UIColor_HexString'
end
