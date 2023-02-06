//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation

class Statement{
    func statement(for customer: Customer) -> String {
        header(for: customer) + customer.rentals.map(detail(for:)).joined() + footer(for: customer)
    }
    
    func header(for customer: Customer) -> String {
        fatalError("subclass-responsibility")
    }
    
    func detail(for rental: Rental) -> String {
        fatalError("subclass-responsibility")
    }
    
    func footer(for customer: Customer) -> String {
        fatalError("subclass-responsibility")
    }

    
}

class TextStatement: Statement {
     override func header(for customer: Customer) -> String {
        return "Rental Record for \(customer.name)\n"
    }
    
     override func detail(for rental: Rental) -> String {
        return "  \(rental.movie.title)  \(rental.getCharge())\n"
    }
    
     override func footer(for customer: Customer) -> String {
        var result = ""
        result += "Amount owed is \(customer.getTotalCharge())\n"
        result += "You earned \(customer.getTotalFrequentRenterPoints()) frequent renter points"
        return result
    }
}

class HtmlStatement: Statement {
     override func header(for customer: Customer) -> String {
        return "<H1>Rentals for <EM>\(customer.name)</EM></H1><P>\n"
    }
    
     override func detail(for rental: Rental) -> String {
        return "  \(rental.movie.title): \(rental.getCharge())<BR>\n"
    }
    
     override func footer(for customer: Customer) -> String {
        var result = ""
        result += "<P>You owe <EM>\(customer.getTotalCharge())</EM><P>\n"
        result += "On this rental you earned <EM>\(customer.getTotalFrequentRenterPoints())</EM> frequent renter points<P>"
        return result
    }
}

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
