
Pod::Spec.new do |s|

  s.version       = "1.0.1"

  s.swift_version = '4.0'

  s.name          = "XLsn0wSwiftKit"
  s.homepage      = "https://github.com/XLsn0w/XLsn0wSwiftKit"
  s.source        = { :git => "https://github.com/XLsn0w/XLsn0wSwiftKit.git", :tag => s.version.to_s }

  s.summary       = "XLsn0w Swift Kit"

  s.author        = { "XLsn0w" => "xlsn0w@outlook.com" }
  s.license       = 'MIT'
  s.platform      = :ios, "8.0"
  s.requires_arc  = true

  s.source_files  = "XLsn0wKit/**/*.swift"

  s.frameworks    = 'UIKit', 'Foundation'

  s.dependency 'SnapKit'
  s.dependency 'Kingfisher'
  s.dependency 'Alamofire'
  s.dependency 'SwiftyJSON'
  s.dependency 'Then'

end
