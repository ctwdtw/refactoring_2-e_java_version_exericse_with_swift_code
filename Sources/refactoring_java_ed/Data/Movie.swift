//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation
public class Movie {
    public enum PriceCode: Int {
        case regular = 0
        case newRelease
        case childrens
    }
    
    private(set) var title: String
    
    public var priceCode: PriceCode
    
    public init(title: String, priceCode: PriceCode) {
        self.title = title
        self.priceCode = priceCode
    }
}
