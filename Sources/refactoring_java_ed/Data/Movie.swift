//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation
public class Movie {
    public enum PriceCode: Int {
        case regular = 0
        case newRelease
        case childrens
    }
    
    private(set) var title: String
    
    public var priceCode: PriceCode
    
    public init(title: String, priceCode: PriceCode) {
        self.title = title
        self.priceCode = priceCode
    }
    
    func getCharge(from daysRented: Int) -> Double {
        var thisAmount: Double = 0
        switch priceCode {
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
        if priceCode == .newRelease && daysRented > 1 {
            result += 1
        }
        return result
    }


}
