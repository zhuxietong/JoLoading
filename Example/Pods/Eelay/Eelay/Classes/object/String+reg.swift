//
//  NSString+MEReg.swift
//  SwiftApp1
//
//  Created by 朱撷潼 on 15/1/16.
//  Copyright (c) 2015年 zhuxietong. All rights reserved.
//

import Foundation
import Swift

public extension String
{
    
    var CGFloatValue:CGFloat
    {
        get{
            let value = NSString(string: self)
            
            return  CGFloat(value.floatValue)
        }
    }
    
    var IntValue:Int
    {
        get{
            let value = NSString(string: self)
            return Int(value.intValue)
        }
    }
}
public struct TPConvert {
    
}

extension TPConvert{
    typealias object = NSMutableDictionary
}

extension TPConvert
{
    
    static func convert<T>(obj:Any?,devfaultV:T) -> T  {
        if let v = obj as? T
        {
            return v
        }
        
        
        let strV = "\(devfaultV)"
        
        
        if T.self == Int.self
        {
            if let v = Int(strV) as? T
            {
                return v
            }
        }
        
        if T.self == CGFloat.self
        {
            if let v = strV.CGFloatValue as? T
            {
                return v
            }
        }
        
        return devfaultV
    }
}


public struct 正则 {
    public static let 网址 = "((http[s]{0,1}|ftp)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(www.[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,3})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)"
    public static let url = "(ht|f)tp(s?)://[0-9a-zA-Z]([-.\\w]*[0-9a-zA-Z])*(:(0-9)*)*(/?)([a-zA-Z0-9-.?,'/\\+&amp;%$#_]*)?"
}


public extension NSString
{
    func subStrings(withReg reg:String)->[String]
    {
        let str = "\(self)"
        return str.subStrings(withReg: reg)
    }
    
    func replace(byReg reg:String,tag:String)->String
    {
        let str = "\(self)"
        return str.replace(byReg: reg, tag: tag)
    }
    
//    func subStringsMatch(withReg reg:String)->[String]
//    {
//        let str = "\(self)"
//        return str.subStringsMatch(withReg: reg)
//    }
    
    func haveString(byReg reg:String) ->Bool
    {
        let str = "\(self)"
        return str.haveSubString(machReg: reg)
    }
    
    
    func firstMach(byReg reg:String) -> String?
    {
        let str = "\(self)"
        return str.firstString(machReg: reg)
    }
    
    
    func valid(byReg reg:String) ->Bool
    {
        let str = "\(self)"
        return str.valid(byReg: reg)
        
    }
}

extension String{
    
    public var jolength:Int
        {
            return self.count
    }
    
    public func subStrings(withReg reg:String)->[String]
    {
        
        var internalExpression: NSRegularExpression?
        do {
            internalExpression = try NSRegularExpression(pattern: reg, options: [])
        } catch _ as NSError {
            internalExpression = nil
        }
        var matchStrings = [String]()
        
        if let matches:[AnyObject] = internalExpression?.matches(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, self.jolength))
        {
            let number = matches.count
            
            if number > 0
            {
                for  matchObj in matches
                {
                    let match:NSTextCheckingResult = matchObj as! NSTextCheckingResult
                    
                    let number = match.numberOfRanges
                    if number>0
                    {
                        for n in 0...(number-1)
                        {
                            let range0 = match.range(at: n)
                            
                            let ns_str = NSString(format: "", self)
                            let subString = ns_str.substring(with: range0)
                            
                            if n==0
                            {
                                matchStrings.append(subString)
                            }
                        }
                    }
                }
            }
        }
        
        
        return matchStrings
        
    }
    
    
    public func replace(byReg reg:String,tag:String)->String
    {
//        let index1 = advance(self.startIndex, 0)
//        let index2 = advance(self.startIndex, 0)
        
//        let range = Range<String.Index>(start: index1, end: index2)
        
        let beginString: String = self.copy() as! String
        
        
        var internalExpression: NSRegularExpression?
        do {
            internalExpression = try NSRegularExpression(pattern: reg, options:[])
        } catch _ as NSError {
            internalExpression = nil
        }
        if let modifyString = internalExpression?.stringByReplacingMatches(in: beginString, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, beginString.jolength), withTemplate: tag)
        {
            return modifyString as String
        }
        
        return beginString
    }
    
    
    public func subStrings(machReg reg:String)->[String]
    {
        var matchStrings = [String]()
        
        do {
            // - 1、创建规则
//            let pattern = "[1-9][0-9]{4,14}"
            let pattern = "\(reg)"
            // - 2、创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // - 3、开始匹配
            let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
            // 输出结果
            for checkingRes in res {
                let one_s = (self as NSString).substring(with: checkingRes.range)
                matchStrings.append(one_s)
                
            } 
        } 
        catch { 
        }
        
        return matchStrings
    }
    
    public func haveSubString(machReg reg:String) ->Bool
    {
        let tmp = self
        
        var have = false
        
        var internalExpression: NSRegularExpression?
        do {
            internalExpression = try NSRegularExpression(pattern: reg, options: [])
        } catch _ as NSError {
            internalExpression = nil
        }
        
        
        internalExpression?.enumerateMatches(in: tmp, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSMakeRange(0, tmp.jolength), using: { (result:NSTextCheckingResult?, flags:NSRegularExpression.MatchingFlags, pointer:UnsafeMutablePointer<ObjCBool>) -> Void in
            
            if (result != nil)
            {
                let number = result!.numberOfRanges
                
                if number > 0
                {
                    have = true
                }
            }
        })
        return have
    }
    
    
    func firstString(machReg reg:String) -> String?
    {
        _ = [String]()
        
        do {
            // - 1、创建规则
            //            let pattern = "[1-9][0-9]{4,14}"
            let pattern = "\(reg)"
            // - 2、创建正则表达式对象
            let regex = try NSRegularExpression(pattern: pattern, options: NSRegularExpression.Options.caseInsensitive)
            // - 3、开始匹配
            let res = regex.matches(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count))
            // 输出结果
            for checkingRes in res {
                let one_s = (self as NSString).substring(with: checkingRes.range)
                return one_s
            }
        }
        catch {
            return nil
        }
        
        
        
        
        return nil
    }
    
    
    func valid(byReg reg:String) ->Bool
    {
        var args = [AnyObject]()
        args.append(reg as AnyObject)
        //        NSPredicate(format: "SELF MATCHES %@", argumentArray: args)
        //        if var predicate = NSPredicate(format: "SELF MATCHES %@",)
        
        if let predicate = NSPredicate(format: "SELF MATCHES %@",argumentArray: args) as NSPredicate?
        {
            return predicate.evaluate(with: NSString(string: self))
        }
        return false
        
    }
    
    
    
    
}
