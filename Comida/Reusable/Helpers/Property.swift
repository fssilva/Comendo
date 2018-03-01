//
//  Property.swift
//  Comida
//
//  Created by Felipe de Sousa Silva on 09.01.18.
//  Copyright © 2018 Netlight. All rights reserved.
//

import Foundation

typealias Property<Value, ID> = GenericProperty<Value, ID, Void>
typealias CollectionProperty<Value, ID> = GenericProperty<Value, ID, CollectionChange>

struct GenericProperty<Value, ID, ChangeInfo> {
    
    private var _value: Value
    var value: Value {
        get { return _value }
        set { set(newValue) }
    }
    let id: ID
    var onChange: ((ID, ChangeInfo?) -> Void)?
    
    init(_ value: Value, _ id: ID, onChange: ((ID, ChangeInfo?) -> Void)? = nil) {
        self._value = value
        self.id = id
        self.onChange = onChange
    }
    
    mutating func set(_ newValue: Value, info: ChangeInfo? = nil, silent: Bool = false) {
        _value = newValue
        if silent == false {
            onChange?(id, info)
        }
    }
}

extension GenericProperty: CustomStringConvertible, CustomDebugStringConvertible {
    var description: String {
        return "{\(id) - \(value)}"
    }
    var debugDescription: String {
        return description
    }
}

infix operator <-

extension GenericProperty {
    
    static func <-(lhs: inout GenericProperty<Value, ID, ChangeInfo>, rhs: Value) {
        lhs.value = rhs
    }
    
    static func <-(lhs: inout GenericProperty<Value, ID, ChangeInfo>, rhs: (newValue: Value, info: ChangeInfo)) {
        lhs.set(rhs.newValue, info: rhs.info)
    }
}

extension GenericProperty {
    mutating func register(_ block: ((ID, Any?) -> Void)?) {
        onChange = { block?($0, $1) }
    }
}

