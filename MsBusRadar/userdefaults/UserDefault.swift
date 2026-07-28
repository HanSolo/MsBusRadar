//
//  UserDefault.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation

@propertyWrapper
struct UserDefault<T: PropertyListValue> {
    let key         : Key
    let defaultValue: T

    var wrappedValue: T? {
        get { UserDefaults(suiteName: Constants.APP_GROUP_ID)!.value(forKey: key.rawValue) as? T ?? defaultValue }
        set { UserDefaults(suiteName: Constants.APP_GROUP_ID)!.set(newValue, forKey: key.rawValue) }
    }
    
    var projectedValue: UserDefault<T> { return self }
    
    func observe(change: @escaping (T?, T?) -> Void) -> NSObject {
        return UserDefaultsObservation(key: key) { old, new in            
            change(old as? T, new as? T)
        }
    }
}

struct Key: RawRepresentable {
    let rawValue: String
}

extension Key: ExpressibleByStringLiteral {
    init(stringLiteral: String) {
        rawValue = stringLiteral
    }
}

// The marker protocol
protocol PropertyListValue {}

extension Data  : PropertyListValue {}
extension String: PropertyListValue {}
extension Date  : PropertyListValue {}
extension Bool  : PropertyListValue {}
extension Int   : PropertyListValue {}
extension Double: PropertyListValue {}
extension Float : PropertyListValue {}

// Every element must be a property-list type
extension Array: PropertyListValue where Element: PropertyListValue {}
extension Dictionary: PropertyListValue where Key == String, Value: PropertyListValue {}
