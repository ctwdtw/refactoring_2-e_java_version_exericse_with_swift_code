//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation

public class Customer {
    private(set) var name: String
    private(set) var rentals: [Rental] = []
    
    public init(name: String) {
        self.name = name
    }
    
    public func addRental(_ rental: Rental) {
        rentals.append(rental)
    }
    
    public func statement() -> String {
        return TextStatement().statement(for: self)
    }
    
    public func htmlStatement() -> String {
        return HtmlStatement().statement(for: self)
    }
    
    func getTotalCharge() -> Double {
        var totalAmount: Double  = 0
        rentals.forEach { each in
            totalAmount += each.getCharge()
        }
        return totalAmount
    }
    
    func getTotalFrequentRenterPoints() -> Int {
        var frequentRenterPoints: Int = 0
        rentals.forEach { each in
            frequentRenterPoints += each.getFrequentRenterPoints()
        }
        return frequentRenterPoints
    }
}
