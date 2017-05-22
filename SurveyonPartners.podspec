Pod::Spec.new do |s|

  s.name         = "SurveyonPartners"
  s.version      = "0.0.2"
  s.summary      = "SOP iOS SDK"

  s.description  = <<-DESC
    This library allows you to integrate surveyonPartners into your iOS app
                   DESC
  s.homepage     = "https://github.com/researchpanelasia/sop-ios-sdk"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author       = { "Kotaro Arimura" => "kotaro.arimura@d8aspring.com", "Choi Jiseon" => "choi.jiseon@d8aspring.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/researchpanelasia/sop-ios-sdk.git", :tag => 'v' + s.version.to_s }
  s.source_files  = "SurveyonPartners/*.{swift,h,m,modulemap}", "SurveyonPartners/Models/*.{swift,xib}","SurveyonPartners/Resources/*.png"
  s.xcconfig = { 'SWIFT_INCLUDE_PATHS' => '$(SRCROOT)/SurveyonPartners/SurveyonPartners' }
end
