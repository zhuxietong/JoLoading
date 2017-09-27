//
//  NSArray-Array.swift
//  app
//
//  Created by tong on 16/6/1.
//  Copyright © 2016年 zhuxietong. All rights reserved.
//

import Foundation


public extension Array
{
    var mutable_array:NSMutableArray
        {
        return (self as NSArray).mutable_array
    }
    
}


public extension Dictionary
{    
    var mutable_dictionary:NSMutableDictionary
        {
        return (self as NSDictionary).mutable_dictionary
    }
}


public extension NSArray
{
    var mutable_array:NSMutableArray{
        let mutable_a = NSMutableArray()
        for v in self
        {
            switch v {
            case let dic as NSDictionary:
                mutable_a.add(dic.mutable_dictionary);break
            case let arr as NSArray:
                mutable_a.add(arr.mutable_array);break
            case let str as String:
                mutable_a.add(str);break
            case let int as Int64:
                mutable_a.add(int);break
            case let int as Int32:
                mutable_a.add(int);break
            case let int as Int:
                mutable_a.add(int);break
            case let flt as Float:
                mutable_a.add(flt);break
            case let dbl as Double:
                mutable_a.add(dbl);break
            case let cgf as CGFloat:
                mutable_a.add(cgf);break
            default:
                mutable_a.add(v)
            }
        }
        return mutable_a
    }
}

public extension NSDictionary
{
    var mutable_dictionary:NSMutableDictionary
    {
        let mutable_d = NSMutableDictionary()
        for (k,v) in self
        {
            switch v {
            case let dic as NSDictionary:
                mutable_d[k] = dic.mutable_dictionary;break
            case let arr as NSArray:
                mutable_d[k] = arr.mutable_array;break
            case let str as String:
                mutable_d[k] = str;break
            case let int as Int64:
                mutable_d[k] = int;break
            case let int as Int32:
                mutable_d[k] = int;break
            case let int as Int:
                mutable_d[k] = int;break
            case let flt as Float:
                mutable_d[k] = flt;break
            case let dbl as Double:
                mutable_d[k] = dbl;break
            case let cgf as CGFloat:
                mutable_d[k] = cgf;break
            default:
                mutable_d[k] = v;break
            }
        }
        return mutable_d
    }
}
