#
# Be sure to run `pod lib lint EcoLanguage.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EcoLanguage'
  s.version          = '0.5.4'
  s.summary          = 'Change the language directly in your App. Handle RTL <-> LTR'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
With this pod, you can change the language inside your application. If the language is a RTL one, the view will automatically be updated.
                            DESC


  s.homepage         = 'http://www.ecocea.com'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Alexis Suard - Ecocea' => 'asuard@ecocea.com' }
  s.source           = { :git => 'https://github.com/ecocea/EcoLanguage.git', :tag => s.version.to_s }

  s.ios.deployment_target = '10.0'
  s.swift_version = '5.0'

  s.source_files = 'EcoLanguage/Classes/**/*'

end
