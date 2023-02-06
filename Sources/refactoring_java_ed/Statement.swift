//
//  File.swift
//  
//
//  Created by P on 2023/2/6.
//

import Foundation
class Statement {
    func statement(for customer: Customer) -> String {
        header(for: customer) + body(for: customer) + footer(for: customer)
    }
    
    func header(for customer: Customer) -> String {
        fatalError("subclass-responsibility")
    }
    
    private func body(for customer: Customer) -> String {
        return customer.rentals.map(body(for:)).joined()
    }
    
    func body(for rental: Rental) -> String {
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
    
     override func body(for rental: Rental) -> String {
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
    
     override func body(for rental: Rental) -> String {
        return "  \(rental.movie.title): \(rental.getCharge())<BR>\n"
    }
    
     override func footer(for customer: Customer) -> String {
        var result = ""
        result += "<P>You owe <EM>\(customer.getTotalCharge())</EM><P>\n"
        result += "On this rental you earned <EM>\(customer.getTotalFrequentRenterPoints())</EM> frequent renter points<P>"
        return result
    }
}
