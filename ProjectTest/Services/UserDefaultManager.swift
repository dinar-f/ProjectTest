//
//  UserDefaultManager.swift
//  ProjectTest
//
//  Created by Dinar on 09.02.2025.
//

import UIKit

class UserDefaultManager {
    static let shared = UserDefaultManager()
    
    func saveValue<T>(_ value: T, forKey key: String) {
        UserDefaults.standard.set(value, forKey: key)
    }
    
    func getValue<T>(forKey key: String) -> T? {
        return UserDefaults.standard.value(forKey: key) as? T
    }
}
