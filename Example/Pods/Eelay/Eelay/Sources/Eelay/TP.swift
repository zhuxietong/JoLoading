//
//  TP.swift
//  eelay
//
//  Created by tong on 2017/7/16.
//  Copyright © 2017年 tong. All rights reserved.
//

import UIKit
public struct TP {
    
}

public protocol NumberValue {
    var doubleValue:Double{get}
}

public protocol StringValue {
    var doubleValue:Double{get}
}

extension String:StringValue{ public var doubleValue:Double{get{return Double(self.cg_float)}}}
extension NSString:StringValue{
    
}

extension Int:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}
extension UInt:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}
extension Int32:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}
extension Int64:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}


extension Float:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}
extension CGFloat:NumberValue{ public var doubleValue:Double{get{return Double(self)}}}
extension Double:NumberValue{ public var doubleValue:Double{get{return self}}}

