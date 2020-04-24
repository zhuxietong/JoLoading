//
//  File.swift
//  
//
//  Created by zhu xietong on 2020/3/21.
//

import Foundation
import UIKit


public class EeArrayGenerator<T>:IteratorProtocol
{
    public typealias Element = T
    var list:NSArray
    var validate_list = NSMutableArray()
    
    var count:Int = 0
    init(list:NSArray)
    {
        self.list = list
        
        validate_list.removeAllObjects()
        for obj in self.list
        {
            if let _ = obj as? T
            {
                validate_list.add(obj)
            }
        }
        self.count = 0
    }
    
    
    public func next() -> Element? {
        if self.count < self.validate_list.count
        {
            let one = self.validate_list[count] as? Element
            count += 1
            
            return one
        }
        
        self.count  = 0
        return nil
        
    }
    
}

open class Each<T> :Sequence{
    
    public typealias Iterator = EeArrayGenerator<T>
    public var list:NSArray
    
    open func makeIterator() -> Iterator {
        return EeArrayGenerator(list: list)
    }
    
    public init(_ list:NSArray)
    {
        self.list = list
    }
}



extension NSArray
{
    public func reverse_list<T>(_ block:(T,Int)->Void) {
        let list = self.reversed()
        var index:Int = 0
        for one in Each<T>(list as NSArray)
        {
            block(one,index)
            index += 1
        }
    }
    public typealias Finish = ()->Void
    
    public func forEach<T>(_ body: (T,Int,Finish) throws -> Void) rethrows {
        var index:Int = 0
        var finish = false
        
        for one in Each<T>(self)
        {

            let finishBlock = {() in
                finish = true
            }
            try body(one,index,finishBlock)
            if (finish){
                return
            }
            index += 1
        }
    }
    
    public func list<T>(_ block:(T,Int)->Void)
    {
        
        var index:Int = 0
        for one in Each<T>(self)
        {
            block(one,index)
            index += 1
        }
        
    }
    
    
    public func listObj<T>(_ block:(T)->Void)
    {
        
        for one in Each<T>(self)
        {
            block(one)
        }
        
    }
}

extension Array{
    
    public func new<T,Obj>(_ creator:(Int,Obj)throws->T) ->[T]{
        
        var new_list = [T]()
        for (index,one) in self.enumerated()
        {
            if let o = one as? Obj
            {
                do {
                    let one = try creator(index,o)
                    new_list.append(one)
                } catch {
                    print(error)
                }
            }
        }
        return new_list
    }
}




