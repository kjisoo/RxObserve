# RxObserve

[![CI Status](https://img.shields.io/travis/kjisoo/RxObserve.svg?style=flat)](https://travis-ci.org/kjisoo/RxObserve)
[![Version](https://img.shields.io/cocoapods/v/RxObserve.svg?style=flat)](https://cocoapods.org/pods/RxObserve)
[![License](https://img.shields.io/cocoapods/l/RxObserve.svg?style=flat)](https://cocoapods.org/pods/RxObserve)
[![Platform](https://img.shields.io/cocoapods/p/RxObserve.svg?style=flat)](https://cocoapods.org/pods/RxObserve)

RxObserve is an extension that allows you to use observe with keypath.

## Getting Started

```swift
class SomeObject: NSObject {
  @objc dynamic var text: String = ""
}

let object = SomeObject()
// in RxCocoa observe, Optional type and must be typed and is a string keypath.
let textObservable = object.rx.observe(String.self, "text") // observe in RxCocoa, It's type is Observable<String?>

// RxObserve
let textObservable = object.rx.asObservable(keyPath: \.text) // It's type is Observable<String>
let textObservable = object.rx.asObservable(keyPath: \.text, options: [.new]) // default value for options is [.initial, .new]

let textObserver = object.rx.asObserver(keyPath: \.text) // It's type is AnyObserver<String>

let view = UIView()
let backgroundColorObservable = view.rx.asObservable(keyPath: \.backgroundColor) // It's type is Observable<UIColor?>
```

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

RxObserve is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'RxObserve'
```

## Author

kjisoo, kim@jisoo.net

## License

RxObserve is available under the MIT license. See the LICENSE file for more info.
