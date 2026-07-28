//
//  ObjectSaveable.swift
//  MsBus
//
//  Created by Gerrit Grunwald on 17.07.26
//

import Foundation


protocol ObjectSaveable {
    func setObject<Object>(_ object: Object, forKey: String) throws where Object: Encodable
    func getObject<Object>(forKey: String, castTo type: Object.Type) throws -> Object where Object: Decodable
}
