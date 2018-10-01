//
//  RxObserve.swift
//
//  Created by kjisoo on 2018. 10. 1..
//

import RxSwift

public extension Reactive where Base: NSObject {
  func asObservable<Value>(keyPath: KeyPath<Base, Value>,
                           options: NSKeyValueObservingOptions = [.initial, .new]) -> Observable<Value> {
    return Observable<Value>.create({ [weak base] (observer) -> Disposable in
      let token = base?.observe(keyPath, options: options, changeHandler: { (base, value) in
        if let value = value.newValue {
          observer.onNext(value)
        }
      })
      return Disposables.create {
        token?.invalidate()
      }
    })
  }
  
  func asObservable<Value: ExpressibleByNilLiteral>(keyPath: KeyPath<Base, Value>,
                                                    options: NSKeyValueObservingOptions = [.initial, .new]) -> Observable<Value> {
    return Observable<Value>.create({ [weak base] (observer) -> Disposable in
      let token = base?.observe(keyPath, options: options, changeHandler: { (base, value) in
        observer.onNext(value.newValue ?? nil)
      })
      return Disposables.create {
        token?.invalidate()
      }
    })
  }
  
  func asObserver<Value>(keyPath: WritableKeyPath<Base, Value>) -> AnyObserver<Value> {
    return AnyObserver<Value> { [weak base] (event) in
      switch event {
      case .next(let value):
        base?[keyPath: keyPath] = value
      case .error(_): break
      case .completed: break
      }
    }
  }
}
