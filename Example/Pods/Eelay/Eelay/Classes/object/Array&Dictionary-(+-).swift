//
//  NSArray+(+-).swift
//  jocool
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation




public func + (array1:NSArray,array2:NSArray)->NSMutableArray
{
    let array = NSMutableArray(array: array1 as [AnyObject])
    array.addObjects(from: array2 as [AnyObject]);
    return array
}

public func += (array1:inout NSMutableArray,array2:NSArray)->NSMutableArray
{
    array1.addObjects(from: array2 as [AnyObject]);
    
    return array1
}



public func - (array1:NSMutableArray,array2:NSArray)->NSMutableArray
{
//    for ob2 in array2
//    {
//        for ob1 in array1
//        {
//            if ob1 === ob2
//            {
//                array1.remove(ob1)
//            }
//        }
//    }
    return array1;
}

public func -= (array1:inout NSMutableArray,array2:NSArray)->NSMutableArray
{
//    for ob2 in array2
//    {
//        for ob1 in array1
//        {
//            if ob1 === ob2
//            {
//                array1.remove(ob1)
//            }
//        }
//    }
    return array1;
}



public func + (dict1:[String:Any],dict2:[String:Any])->[String:Any]
{
    var dict = [String:AnyObject]()
    var keys = [String]()
    for key in dict1.keys
    {
        if !keys.contains(key)
        {
            keys.append(key)
        }
    }
    
    for key in dict2.keys
    {
        
        if !keys.contains(key)
        {
            keys.append(key)
        }
    }
    
    
    for key in keys
    {
        if let value = dict1[key]
        {
            dict[key] = value as AnyObject?
        }
        if let value = dict2[key]
        {
            dict[key] = value as AnyObject?
        }
    }
    
    return dict
}

public func + (dict1:[String:String],dict2:[String:String])->[String:String]
{
    var dict = [String:String]()
    var keys = [String]()
    for key in dict1.keys
    {
        if !keys.contains(key)
        {
            keys.append(key)
        }
    }
    
    for key in dict2.keys
    {
        
        if !keys.contains(key)
        {
            keys.append(key)
        }
    }
    
    
    for key in keys
    {
        if let value = dict1[key]
        {
            dict[key] = value
        }
        if let value = dict2[key]
        {
            dict[key] = value
        }
    }
    
    return dict
}






