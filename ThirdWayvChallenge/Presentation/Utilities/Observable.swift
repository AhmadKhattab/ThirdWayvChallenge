//
//  Observable.swift
//  ThirdWayvChallenge
//
//  Created by Ahmad Ashraf Khattab on 16/12/2022.
//

import Foundation

final class Observable<Value> {
    
    struct Observer<WrappedValue> {
        weak var observer: AnyObject?
        let block: (WrappedValue) -> Void
    }
    // MARK: - Properties
    private var observers = [Observer<Value>]()
    var value: Value? {
        didSet { notifyObservers() }
    }
    // MARK: - Initializer(s)
    init(_ value: Value?) {
        self.value = value
    }
    // MARK: - Instance Method(s)
    func observe(on observer: AnyObject, observerBlock: @escaping (Value) -> Void) {
        observers.append(Observer(observer: observer, block: observerBlock))
    }
    func remove(observer: AnyObject) {
        observers = observers.filter { $0.observer !== observer }
    }
    private func notifyObservers() {
        guard let value = value else { return }
        for observer in observers {
            DispatchQueue.main.async { observer.block(value) }
        }
    }
}
