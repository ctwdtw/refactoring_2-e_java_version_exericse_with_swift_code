//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation
public class Customer {
    private(set) var name: String
    private var rentals: [Rental] = []
    
    public init(name: String) {
        self.name = name
    }
    
    public func addRental(_ rental: Rental) {
        rentals.append(rental)
    }
    
    public func statement() -> String {
        var totalAmount: Double  = 0
        var frequentRentalPoints: Int = 0
        var result: String = "Rental Record for \(name)\n"
        // determine amounts for each rental
        rentals.forEach { each in
            let thisAmount = amountFor(each)
            
            // add frequent renter points
            frequentRentalPoints += 1
            // add bonus for a two day new release rental
            if each.movie.priceCode == .newRelease && each.daysRented > 1 {
                frequentRentalPoints += 1
            }
            // show figures for this rental
            result += "  \(each.movie.title)  \(thisAmount)\n"
            totalAmount += thisAmount
        }
        
        // add footer lines
        result += "Amount owed is \(totalAmount)\n"
        result += "You earned \(frequentRentalPoints) frequent renter points"
        return result
    }
    
    private func amountFor(_ aRental: Rental) -> Double {
        return aRental.getCharge()
    }
    
}
