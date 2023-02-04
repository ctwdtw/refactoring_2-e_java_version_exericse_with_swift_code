//
//  File.swift
//  
//
//  Created by P on 2023/2/4.
//

import Foundation
class Price {
    func getPriceCode() -> Movie.PriceCode {
        fatalError("subclass responsibility")
    }
}

class ChildrensPrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .childrens
    }
}

class NewReleasePrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .newRelease
    }
}

class RegularPrice: Price {
    override func getPriceCode() -> Movie.PriceCode {
        .regular
    }
}
