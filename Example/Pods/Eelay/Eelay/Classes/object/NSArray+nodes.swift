//
//  Collection+nodesswift
//  MESwiftExtention
//
//  Created by 朱撷潼 on 15/3/12.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import Foundation
public protocol NodeGetSetSupport {
    subscript(obj node:String,value:Any?) -> Any?{get}
    subscript(node:String,value:String?) -> String {get}
    func get<T>(node:String,defaultV:T) -> T
    func set(node:String,obj:Any)
    
}



extension NSMutableArray:NodeGetSetSupport{
    
    public subscript(obj node:String,value:Any?) -> Any? {
        get {
            
            if let obj = self.value(obj: node)
            {
                return obj
            }
            return value
        }
    }
    
    public subscript(node:String,value:String?) -> String {
        get {
            if let obj = self.value(obj: node)
            {
                return "\(obj)"
            }
            
            
            if let rValue = value
            {
                return rValue
            }
            else
            {
                return ""
            }
        }
    }
    
    public func get<T>(node: String, defaultV: T) -> T {
        
        let _v = self.value(obj: node)
        
        if let v = _v as? T
        {
            return v
        }
        
        return TPConvert.convert(obj: _v, devfaultV: defaultV)
    }
    
    public func set(node: String, obj: Any) {
        //        print("\(#file)\(#line)")
    }
}


extension NSMutableArray
{
    
    
    func value(obj node:String) -> AnyObject?
    {
        var newNode = node
        return self.getValueWithNodes(nodes: &newNode)
    }
    
    
    
    
    func getValueWithNodes(nodes:inout String) -> AnyObject?
    {
        let paths = nodes.components(separatedBy:".")
        var newPaths = [String]()
        
        
        for (index,value) in paths.enumerated()
        {
            if index != 0
            {
                newPaths.append(value)
            }
        }
        nodes = newPaths.joined(separator: ".")
        
        if paths.count > 0
        {
            
            let value0 = paths[0]
            if let index = Int(value0)
            {
                if self.count > index
                {
                    if let obj = self.object(at: index) as? NSMutableArray
                    {
                        if paths.count > 1
                        {
                            return obj.getValueWithNodes(nodes: &nodes)
                        }
                        else
                        {
                            
                            return self.object(at: index) as AnyObject
                            
                        }
                    }
                    else if let obj = self.object(at: index) as? NSMutableDictionary
                    {
                        if paths.count > 1
                        {
                            return obj.getValueWithNodes(nodes: &nodes) as AnyObject
                        }
                        else
                        {
                            return self.object(at: index) as AnyObject
                        }
                    }
                    else
                    {
                        
                        if paths.count < 2
                        {
                            return self.object(at: index) as AnyObject
                        }
                        else
                        {
                            return nil
                        }
                        
                    }
                }
            }
        }
        return nil
    }
}

extension NSMutableArray
{
    public func findItemForInfo(value:String, key:String) ->NSMutableDictionary?
    {
        var dict :NSMutableDictionary? = nil
        for aitem in self
        {
            if let item = aitem as? NSMutableDictionary
            {
                
                if let temp = item.findItemForInfo(value: value, key: key)
                {
                    dict = temp
                }
            }
            if let item = aitem as? NSMutableArray
            {
                if let temp = item.findItemForInfo(value: value, key: key)
                {
                    dict = temp
                }
            }
            
        }
        return dict
    }
}
