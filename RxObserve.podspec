Pod::Spec.new do |s|
  s.name             = 'RxObserve'
  s.version          = '0.1.0'
  s.summary          = 'A short description of RxObserve.'

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/kjisoo/RxObserve'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'kjisoo' => 'kim@jisoo.net' }
  s.source           = { :git => 'https://github.com/kjisoo/RxObserve.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/**/*.swift'

  s.dependency 'RxSwift', '>= 4.0'
  s.dependency 'RxCocoa', '>= 4.0'
end
