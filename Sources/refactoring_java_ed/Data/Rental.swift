//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation
public class Rental {
    private(set) var movie: Movie
    private(set) var daysRented: Int
    
    public init(movie: Movie, daysRented: Int) {
        self.movie = movie
        self.daysRented = daysRented
    }
    
    func getCharge() -> Double {
        var thisAmount: Double = 0
        switch movie.priceCode {
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
}
