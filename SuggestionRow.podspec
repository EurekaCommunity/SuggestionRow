Pod::Spec.new do |s|
  s.name             = "SuggestionRow"
  s.version          = "3.2.0"
  s.summary          = "Eureka row that displays completion suggestions either below the row in a table view or in the input accessory view above the keyboard."
  s.homepage         = "https://github.com/EurekaCommunity/SuggestionRow"
  s.license          = { type: 'MIT', file: 'LICENSE' }
  s.author           = { "Xmartlabs SRL" => "swift@xmartlabs.com" }
  s.source           = { git: "https://github.com/EurekaCommunity/SuggestionRow.git", tag: s.version.to_s }
  s.social_media_url = 'https://twitter.com/EurekaCommunity'
  s.ios.deployment_target = '9.3'
  s.requires_arc = true
  s.ios.source_files = 'Sources/**/*.{swift}'
  s.dependency 'Eureka', '~> 5.2'
  s.swift_version = "5.0"
end
