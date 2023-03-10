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
        return movie.getCharge(from: daysRented)
    }
    
    func getFrequentRenterPoints() -> Int {
        return movie.getFrequentRenterPoints(from: daysRented)
    }
}
