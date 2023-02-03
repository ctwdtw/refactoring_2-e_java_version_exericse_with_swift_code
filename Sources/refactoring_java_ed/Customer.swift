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
        var frequentRenterPoints: Int = 0
        var result: String = "Rental Record for \(name)\n"
        // determine amounts for each rental
        rentals.forEach { each in
            // add frequent renter points
            frequentRenterPoints += each.getFrequentRenterPoints()
            // show figures for this rental
            result += "  \(each.movie.title)  \(each.getCharge())\n"
        }
        
        // add footer lines
        result += "Amount owed is \(getTotalCharge())\n"
        result += "You earned \(frequentRenterPoints) frequent renter points"
        return result
    }
    
    private func getTotalCharge() -> Double {
        var totalAmount: Double  = 0
        rentals.forEach { each in
            totalAmount += each.getCharge()
        }
        return totalAmount
    }
}
