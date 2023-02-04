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
        var result: String = "Rental Record for \(name)\n"
        // determine amounts for each rental
        rentals.forEach { each in
            // show figures for this rental
            result += "  \(each.movie.title)  \(each.getCharge())\n"
        }
        
        // add footer lines
        result += "Amount owed is \(getTotalCharge())\n"
        result += "You earned \(getTotalFrequentRenterPoints()) frequent renter points"
        return result
    }
    
    public func htmlStatement() -> String {
        var result: String = "<H1>Rentals for <EM>\(name)</EM></H1><P>\n"
        // determine amounts for each rental
        rentals.forEach { each in
            // show figures for this rental
            result += "  \(each.movie.title): \(each.getCharge())<BR>\n"
        }
        
        // add footer lines
        result += "<P>You owe <EM>\(getTotalCharge())</EM><P>\n"
        result += "On this rental you earned <EM>\(getTotalFrequentRenterPoints())</EM> frequent renter points<P>"
        return result
    }
    
    private func getTotalCharge() -> Double {
        var totalAmount: Double  = 0
        rentals.forEach { each in
            totalAmount += each.getCharge()
        }
        return totalAmount
    }
    
    private func getTotalFrequentRenterPoints() -> Int {
        var frequentRenterPoints: Int = 0
        rentals.forEach { each in
            frequentRenterPoints += each.getFrequentRenterPoints()
        }
        return frequentRenterPoints
    }
}
