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
            // add frequent renter points
            frequentRentalPoints += self.frequentRenterPoints(each)
            // show figures for this rental
            result += "  \(each.movie.title)  \(each.getCharge())\n"
            totalAmount += each.getCharge()
        }
        
        // add footer lines
        result += "Amount owed is \(totalAmount)\n"
        result += "You earned \(frequentRentalPoints) frequent renter points"
        return result
    }
    
    private func frequentRenterPoints(_ aRental: Rental) -> Int {
        aRental.getFrequentRenterPoints()
    }
}
