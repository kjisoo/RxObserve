//
//  RxObserve.swift
//
//  Created by kjisoo on 2018. 10. 1..
//

import RxSwift


public extension Reactive where Base: NSObject {
  func observe<Value>(keyPath: KeyPath<Base, Value>, options: NSKeyValueObservingOptions) -> Observable<Value> {
    return Observable<Value>.create({ (observer) -> Disposable in
      let token = self.base.observe(keyPath, options: options, changeHandler: { (base, b) in
        if let a = b.newValue {
          observer.onNext(a)
        }
      })
      return Disposables.create {
        token.invalidate()
      }
    })
  }
  
  func observe<Value>(keyPath: KeyPath<Base, Value>) -> Observable<Value> {
    return observe(keyPath: keyPath, options: [.initial, .new, .prior, .old])
  }
  
  func observe<Value: ExpressibleByNilLiteral>(keyPath: KeyPath<Base, Value>, options: NSKeyValueObservingOptions) -> Observable<Value> {
    return Observable<Value>.create({ (observer) -> Disposable in
      let token = self.base.observe(keyPath, options: options, changeHandler: { (base, b) in
        observer.onNext(b.newValue ?? nil)
        
      })
      return Disposables.create {
        token.invalidate()
      }
    })
  }
  
  func observe<Value: ExpressibleByNilLiteral>(keyPath: KeyPath<Base, Value>) -> Observable<Value> {
    return observe(keyPath: keyPath, options: [.initial, .new, .prior, .old])
  }
  
  func o<Value>(keyPath: WritableKeyPath<Base, Value>) -> AnyObserver<Value> {
    weak var seakBase = base
    return AnyObserver<Value> { (event) in
      switch event {
      case .next(let value):
        seakBase?.setValue(value, forKey: NSExpression(forKeyPath: keyPath).keyPath)
      case .error(_): break
        
      case .completed: break
        
      }
    }
  }
}
