//
//  main.swift
//  SimpleDomainModel
//
//  Created by Ted Neward on 4/6/16.
//  Copyright © 2016 Ted Neward. All rights reserved.
//

import Foundation

print("Hello, World!")

public func testMe() -> String {
  return "I have been tested"
}

open class TestMe {
  open func Please() -> String {
    return "I have been tested"
  }
}

////////////////////////////////////
// Money
//
public struct Money {
  public var amount : Int
  public var currency : String
  
    init(amount: Int, currency: String) {
        self.amount = amount
        self.currency = currency
    }
    
    
  public func convert(_ to: String) -> Money {
    var newAmount = 0
    
    switch (currency, to) {
    case ("USD", "GBP"):
        newAmount = (Int(Double(self.amount) / 2.0))
    case ("USD", "EUR"):
        newAmount = (Int(Double(self.amount) * 1.5))
    case ("USD", "CAN"):
        newAmount = (Int(Double(self.amount) * 1.25))
    case ("GBP", "USD"):
        newAmount = (Int(Double(self.amount) * 2.0))
    
    case ("EUR","USD"):
        newAmount = (Int(Double(self.amount) / 1.5))
    
    case ("CAN","USD"):
        newAmount = (Int(Double(self.amount) / 1.25))
    default:
        newAmount = (Int(Double(self.amount)))
    }
    
    return Money(amount: newAmount, currency: to)
    
  }
    
  
  public func add(_ to: Money) -> Money {
    let convertedMoney = self.convert(to.currency)
    let newAmount = convertedMoney.amount + to.amount
    
    return Money(amount: newAmount, currency: to.currency)
  }
    
  public func subtract(_ from: Money) -> Money {
    let convertedMoney = self.convert(from.currency)
    let newAmount = from.amount - convertedMoney.amount
    
    return Money(amount: newAmount, currency: from.currency)
    
  }
}

////////////////////////////////////
// Job
//
open class Job {
  fileprivate var title : String
  fileprivate var type : JobType

  public enum JobType {
    case Hourly(Double)
    case Salary(Int)
  }
  
  public init(title : String, type : JobType) {
    self.title = title
    self.type = type
    
  }
  
  open func calculateIncome(_ hours: Int) -> Int {
    switch  self.type {
    case .Hourly(let val):
        return Int(val) * hours
    case .Salary(let val):
        return val
  }
}
func raise(_ amt : Double) {
    switch self.type {
    case .Hourly(let val):
        self.type = JobType.Hourly(val + amt)
    case .Salary(let val):
        self.type = JobType.Salary(val + Int(amt))
    }
  }
    
}
    
    
////////////////////////////////////
// Person
//
open class Person {
  open var firstName : String = ""
  open var lastName : String = ""
  open var age : Int = 0

    
    public init(firstname: String, lastName: String, age: Int){
        self.firstName = firstname
        self.lastName = lastName
        self.age = age
        
    }
    
    
  fileprivate var _job : Job? = nil
  open var job : Job? {
    get {return _job}
    set(value) {
        if self.age >= 16{
            _job = value
        }
        
    }
  }
  
  fileprivate var _spouse : Person? = nil
  open var spouse : Person? {
    get {return _spouse}
    set(value) {
        if self.age >= 18{
            _spouse = value
        }
    }
  }
  
  public init(firstName : String, lastName: String, age : Int) {
    self.firstName = firstName
    self.lastName = lastName
    self.age = age
  }
  
  open func toString() -> String {
    return "[Person: firstName:\(self.firstName) lastName:\(self.lastName) age:\(self.age) job:\(String(describing: _job)) spouse:\(String(describing: _spouse))]"

  }
}

////////////////////////////////////
// Family
//
open class Family {
  fileprivate var members : [Person] = []
  
  public init(spouse1: Person, spouse2: Person) {
    if spouse1.spouse == nil && spouse2.spouse == nil {
        spouse1.spouse = spouse2
        spouse2.spouse = spouse1
        self.members.append(spouse2)
        self.members.append(spouse1)
        
    }
  }
  
  open func haveChild(_ child: Person) -> Bool {
    if members[0].age >= 21 || members[1].age >= 21 {
        members.append(child)
        return true
    }
    
    return false
    
  }
  
    open func householdIncome() -> Int {
        var total = 0
        for member in members {
            if member.job != nil {
                switch member.job!.type {
                case .Salary(let val):
                    total = total + val
                case .Hourly(let val):
                    total = total + Int(val * Double(2000))
                }
            }
        }
        return total
    }
    
}

