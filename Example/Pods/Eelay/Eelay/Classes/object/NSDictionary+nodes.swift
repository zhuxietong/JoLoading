//
//  Collection+nodesswift
//  MESwiftExtention
//
//  Created by 朱撷潼 on 15/3/12.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import Foundation




extension NSMutableDictionary:NodeGetSetSupport{
    
    public subscript(obj node:String,value:Any?) -> Any? {
        get {
            
            if let obj = self.value(obj: node)
            {
                return obj as AnyObject?
            }
            return value
        }
    }
    
    
    public func possible(_ nodes:String...,default:String)->String{
        var value = ""
        for one in nodes {
            let v = self[one,""]
            if v.count > 0
            {
                value = v
                break
            }
        }
        
        if value.count < 1
        {
            value = `default`
        }
        return value
    }
    
    public func any<T>(nodes:String...,default:T)->T{
        
//
        var vl = `default`
        for node in nodes {
            if let v = self.value(obj: node) as? T
            {
                vl = v
                break
            }
        }
        
        return vl
    }
    
    
    
    public subscript(node:String,value:String?) -> String {
        get {

            if let obj = self.value(obj: node)
            {
                
                if let str = obj as? String
                {
                    return str
                }
                var v = "\(obj)"
                if v == "<null>"
                {                
                    v = ""
                }
                return v
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
        
        return TPConvert.convert(obj: _v as AnyObject?, devfaultV: defaultV)
    }
    
    public func set(node: String, obj: Any) {
    
        self.set(value: obj as AnyObject, toNode: node)
    }
    
    public func set(object: Any, forNode: String) {
        
        self.set(value: object as AnyObject, toNode: forNode)
    }
    
 
}





extension NSMutableDictionary
{

    func update(with value:Any?,selector:String,targetKey:String)
    {
        let infoKey = selector.firstString(machReg: "^[^\\<]+")!
        let infoValueString = selector.firstString(machReg:"(?<=\\<)[^\\>]+")!
        let values = infoValueString.components(separatedBy: ";")
        if value != nil                {
            for oneValue in values
            {
                if let dict = self.findItemForInfo(value: oneValue, key: infoKey)
                {
                    dict.setObject(value!, forKey: targetKey as NSCopying)
                }
            }
        }
    }
    
    
    func getValueWithNodes(nodes:inout String) -> Any?
    {
        if  nodes == ""
        {
            return self
        }
        
        
        let paths = nodes.components(separatedBy: ".")
        var newPaths = [String]()
        
       
        for (index,value) in paths.enumerated()
        {
            
            if index != 0
            {
                newPaths.append(value)
            }
        }
        
        nodes = newPaths.joined(separator: ".")
        
        let value0 = paths[0]
        
        if let obj = self.object(forKey: value0) as? NSMutableDictionary
        {
          
            if paths.count > 1
            {
                return obj.getValueWithNodes(nodes: &nodes)
            }
            else
            {
                
                if let v = self.object(forKey: value0)
                {
                    return v
                }
                else{
                    return nil
                }
            }
        }
        else if let obj = self.object(forKey: value0) as? NSMutableArray
        {

            if paths.count > 1
            {
                return obj.getValueWithNodes(nodes: &nodes)
            }
            else
            {
               
                if let v = self.object(forKey: value0)
                {
                    return v
                }
                else{
                    return nil
                }

            }
        }
        else
        {
            
            if paths.count < 2
            {

                
                if let v = self.object(forKey: value0)
                {
                    
                    return v
                }
                else{
                    return nil
                }
            }
            else
            {
                return nil
            }
        }
    }
    
    public func value(obj node:String) -> Any?
    {
        var newNode = node

        let obj = self.getValueWithNodes(nodes: &newNode)
        return obj
    }
    
    public func set(value:AnyObject?,toNode:String)
    {
        var paths = toNode.components(separatedBy: ".")
        let name = paths.last
        
        if paths.count > 2
        {
            paths.removeLast()
        }
        if paths.count == 1
        {
            if let v = value
            {
                self.setObject(v, forKey: paths[0] as NSCopying)
            }
        }

        
        
//        let newNode = paths.mutable_array.componentsJoined(by: ".")
        
        let newNode = paths.joined(separator: ".")

        

        if let dic = self.value(obj: newNode) as? NSMutableDictionary
        {
            if value != nil && name != nil{
                dic.setObject(value!, forKey: name! as NSCopying)
            }
        }

        
        
    }
    
    //    subscript(node:String) ->AnyObject{
    //        get{
    //            if let obj = self.value(node: node)
    //            {
    //                return obj
    //            }
    //            return value
    //        }
    //    }
    
    
    
    
}

extension NSMutableDictionary
{
    
    public subscript(find key:String,_ value:String)->NSMutableDictionary?{
        return self.findItemForInfo(value: value, key: key)
    }
    public func findItemForInfo(value:String, key:String) ->NSMutableDictionary?
    {
        var dict :NSMutableDictionary? = nil
        let allKeys = self.allKeys
        var haveMach = false
        for akey in allKeys
        {

            if let keyStr = akey as? String
            {
                if keyStr == key
                {

                    if let aValue = self.object(forKey: akey) as? String
                    {
                        if aValue == value
                        {
                            haveMach = true
                            dict = self

                            return dict

                        }
                    }
                    
                }
            }
        }
        
        if haveMach == false
        {
            for akey in allKeys
            {
                if let item = self.object(forKey: akey) as? NSMutableDictionary
                {
                    if let temp = item.findItemForInfo(value: value, key: key)
                    {
                        dict = temp
                    }
                }
                
                if let item = self.object(forKey: akey) as? NSMutableArray
                {
                    if let temp = item.findItemForInfo(value: value, key: key)
                    {
                        dict = temp
                    }
                }
            }
            
        }
        return dict
    }
}

