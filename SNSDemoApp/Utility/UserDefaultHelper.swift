//
//  UserDefaultHelper.swift
//  SNSDemoApp
//
//  Created by 入江真礼 on 2020/05/08.
//  Copyright © 2020 入江真礼. All rights reserved.
//


import Foundation
import Firebase

protocol KeyNamespaceable {
    func namespaced<T: RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceable {

    func namespaced<T: RawRepresentable>(_ key: T) -> String {
        return "\(Self.self).\(key.rawValue)"
    }
}

protocol StringDefaultSettable : KeyNamespaceable {
    associatedtype StringKey : RawRepresentable
}

extension StringDefaultSettable where StringKey.RawValue == String {

    func set(_ value: String?, forKey key: StringKey) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }

    @discardableResult
    func string(forKey key: StringKey) -> String? {
        let key = namespaced(key)
        return UserDefaults.standard.string(forKey: key)
    }
}

protocol BoolDefaultSettable : KeyNamespaceable {
    associatedtype BoolKey : RawRepresentable
}

extension BoolDefaultSettable where BoolKey.RawValue == String {

    func set(_ value: Bool, forKey key: BoolKey) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }

    @discardableResult
    func bool(forKey key: BoolKey) -> Bool {
        let key = namespaced(key)
        return UserDefaults.standard.bool(forKey: key)
    }
}

protocol IntDefaultSettable : KeyNamespaceable {
    associatedtype IntKey : RawRepresentable
}

extension IntDefaultSettable where IntKey.RawValue == String {

    func set(_ value: Int?, forKey key: IntKey) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }

    @discardableResult
    func integer(forKey key: IntKey) -> Int? {
        let key = namespaced(key)
        return UserDefaults.standard.integer(forKey: key)
    }
}

protocol StringArrayDefaultSettable : KeyNamespaceable {
    associatedtype StringArrayKey : RawRepresentable
}

extension StringArrayDefaultSettable where StringArrayKey.RawValue == String {

    func set(_ value: [String], forKey key: StringArrayKey) {
        let key = namespaced(key)
        UserDefaults.standard.set(value, forKey: key)
    }

    @discardableResult
    func array(forKey key: StringArrayKey) -> [String] {
        let key = namespaced(key)
        return (UserDefaults.standard.array(forKey: key) as? [String] ?? [])
    }
}

protocol LoginDefaultSettable : KeyNamespaceable {
    associatedtype StructKey : RawRepresentable
}

extension LoginDefaultSettable where StructKey.RawValue == String {

    func set(_ value: User, forKey key: StructKey) {
        let key = namespaced(key)
        let data = ["id": value.uid, "email": value.email!, "name": value.displayName!] as [String : Any]
        UserDefaults.standard.set(data, forKey: key)
    }

    func removeObject(forKey: StructKey) {
        let key = namespaced(forKey)
        UserDefaults.standard.removeObject(forKey: key)
    }

    @discardableResult
    func dictionary(forKey key: StructKey) -> [String: Any]? {
        let key = namespaced(key)
        return UserDefaults.standard.dictionary(forKey: key)
    }
}

extension UserDefaults: LoginDefaultSettable {

    /// Decodable型のデータ・タイプ
    ///
    /// - nowCheckinShop: CheckinResponse
    enum StructKey: String {
        case nowLoginUser
    }
}
