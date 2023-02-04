//
//  File.swift
//  
//
//  Created by P on 2023/2/3.
//

import Foundation

/// 我們不能用繼承的方式去處理 `Movie` class 中的 switch statement, 以下的 class diagram 是行不通的:
/// RegularMovie -|> Movie
/// ChildrensMovie -|> Movie
/// NewReleaseMovie -|> Movie
/// 我們用 `Movie.title` 來當作 id (多新增 id 的欄位也是一樣的結果), 一部新上映的影片 (ex. NewRelease(id: 15478, title: "灌籃高手"))
/// 可能在經過幾週後，就不是新上映了，此時 id = 15478, title = "灌籃高手" 的 Movie 物件仍然繼承 `NewRelease` 就顯得不合理，
/// 我們希望客戶在不同的年度租借 id = 15478, title = "灌籃高手" 的 Movie 物件時，系統會列印出不同的報價，而物件不能在不同的時間 (週、月、季、年)
/// 修改自己所處的 class, 所以上面的 class diagram 是行不通的。
/// 作者於是提出了 p.38 的 state pattern, 讓 Movie 的 price 欄位可以在不同的的時間 (週、月、季、年)，可以隨時被修改。
public class Movie {
    public enum PriceCode: Int {
        case regular = 0
        case newRelease
        case childrens
    }
    
    private(set) var title: String
    
    private var priceCode: PriceCode!
    
    public init(title: String, priceCode: PriceCode) {
        self.title = title
        self.setPriceCode(priceCode)
    }
    
    public func setPriceCode(_ priceCode: PriceCode) {
        self.priceCode = priceCode
    }
    
    public func getPriceCode() -> PriceCode {
        return priceCode
    }
    
    func getCharge(from daysRented: Int) -> Double {
        var thisAmount: Double = 0
        switch getPriceCode() {
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
    
    func getFrequentRenterPoints(from daysRented: Int) -> Int {
        var result = 1
        // add bonus for a two day new release rental
        if getPriceCode() == .newRelease && daysRented > 1 {
            result += 1
        }
        return result
    }
}
