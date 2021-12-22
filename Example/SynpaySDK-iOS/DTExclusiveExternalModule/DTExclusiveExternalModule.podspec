Pod::Spec.new do |s|
  s.name = "DTExclusiveExternalModule"
  s.version = "1.0.0"
  s.summary = "A short description of DTExclusiveExternalModule."
  s.homepage     = "http://gitlab.alibaba-inc.com/DTKExtension/DTExclusiveExternalModule.git"
  s.author             = { "路客" => "lucheng.zlc@alibaba-inc.com" }
  s.license          =  "MIT"
  s.description = "TODO: Add long description of the pod here."
  s.frameworks = ["Foundation", "AVFoundation", "UIKit", "SystemConfiguration"]
  

  s.source = { :path => '.' }
  s.ios.deployment_target    = '8.0'
  s.ios.vendored_framework   = '*.framework'
  s.source_files = '**/*.{h,m}'
  s.static_framework = true

end
