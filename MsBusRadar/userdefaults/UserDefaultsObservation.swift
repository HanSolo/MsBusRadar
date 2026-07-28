//
//  UserDefaultsObservation.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation

class UserDefaultsObservation: NSObject {
    let key: Key
    private var onChange: (Any, Any) -> Void

    init(key: Key, onChange: @escaping (Any, Any) -> Void) {
        self.onChange = onChange
        self.key      = key
        super.init()
        UserDefaults(suiteName: Constants.APP_GROUP_ID)!.addObserver(self, forKeyPath: key.rawValue, options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        guard let change = change, object != nil, keyPath == key.rawValue else { return }
        onChange(change[.oldKey] as Any, change[.newKey] as Any)
    }
    
    deinit {
        UserDefaults(suiteName: Constants.APP_GROUP_ID)!.removeObserver(self, forKeyPath: key.rawValue, context: nil)
    }
}
