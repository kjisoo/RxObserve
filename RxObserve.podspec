Pod::Spec.new do |s|
  s.name             = 'RxObserve'
  s.version          = '0.2.0'
  s.summary          = 'RxSwift Extension for easier use of observe.'

  s.description      = <<-DESC
RxSwift Extension for easier use of observe.
RxObserve is an extension that allows you to use observe with keypath.
                       DESC

  s.homepage         = 'https://github.com/kjisoo/RxObserve'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kjisoo' => 'kim@jisoo.net' }
  s.source           = { :git => 'https://github.com/kjisoo/RxObserve.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.2'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'RxSwift', '>= 4.0'
  s.dependency 'RxCocoa', '>= 4.0'
end
