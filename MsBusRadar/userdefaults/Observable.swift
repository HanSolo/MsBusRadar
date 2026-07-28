//
//  Observable.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation

struct Observable<T> {
    typealias Observer = String

    private var observers: [Observer: (T) -> Void] = [:]

    var value: T {
        didSet {
            observers.forEach { $0.value(value) }
        }
    }

    init(_ value: T) {
        self.value = value
    }

    @discardableResult
    mutating func addObserver(_ observer: @escaping (T) -> Void) -> Observer {
        let key = UUID().uuidString as Observer
        observers[key] = observer
        return key
    }

    mutating func removeObserver(_ key: Observer) {
        observers.removeValue(forKey: key)
    }
}
