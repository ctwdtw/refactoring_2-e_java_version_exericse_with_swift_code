//
//  File.swift
//  
//
//  Created by P on 2023/2/4.
//

import Foundation
class Price {
    func getCharge(from daysRented: Int) -> Double {
        fatalError("subclass responsibility")
    }
    
    func getFrequentRenterPoints(from daysRented: Int) -> Int {
        return 1
    }
}

class ChildrensPrice: Price {
    override func getCharge(from daysRented: Int) -> Double {
        var thisAmount: Double = 0
        thisAmount += 1.5
        if daysRented > 3 {
            thisAmount += Double(daysRented - 3)*1.5
        }
        return thisAmount
    }
}

class NewReleasePrice: Price {
    override func getCharge(from daysRented: Int) -> Double {
        return Double(daysRented * 3)
    }
    
    override func getFrequentRenterPoints(from daysRented: Int) -> Int {
        if daysRented > 1 {
            return super.getFrequentRenterPoints(from: daysRented) + 1
        } else {
            return super.getFrequentRenterPoints(from: daysRented)
        }
    }
}

class RegularPrice: Price {
    override func getCharge(from daysRented: Int) -> Double {
        var thisAmount: Double = 0
        thisAmount += 2
        if daysRented > 2 {
            thisAmount += Double(daysRented - 2)*1.5
        }
        return thisAmount
    }
}
