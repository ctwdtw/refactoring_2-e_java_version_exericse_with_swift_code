//
//  File.swift
//  
//
//  Created by P on 2023/2/4.
//

import Foundation
class Price {
    func getPriceCode() -> Movie.PriceCode {
        fatalError("subclass responsibility")
    }
    
    func getCharge(from daysRented: Int) -> Double {
        var thisAmount: Double = 0
        switch getPriceCode() {
        case .regular:
            thisAmount += 2
            if daysRented > 2 {
                thisAmount += Double(daysRented - 2)*1.5
            }
        case .newRelease:
            thisAmount += Double(daysRented * 3)
        case .childrens:
            thisAmount += 1.5
            if daysRented > 3 {
                thisAmount += Double(daysRented - 3)*1.5
            }
        }
        
        return thisAmount
    }
    
    func getFrequentRenterPoints(from daysRented: Int) -> Int {
        var result = 1
        // add bonus for a two day new release rental
        if getPriceCode() == .newRelease && daysRented > 1 {
            result += 1
        }
        return result
    }
}

class ChildrensPrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .childrens
    }
}

class NewReleasePrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .newRelease
    }
}

class RegularPrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .regular
    }
}
