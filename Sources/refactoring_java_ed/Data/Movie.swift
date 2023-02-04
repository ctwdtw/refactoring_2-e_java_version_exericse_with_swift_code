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
    
    private var price: Price!
    
    public init(title: String, priceCode: PriceCode) {
        self.title = title
        self.setPriceCode(priceCode)
    }
    
    /// 使用 `Self Encapsulate Field (171)`, 去建立 `setPriceCode()` 和 `getPricecode` 的好處是，
    /// 當我們替換 `Movie.priceCode` 為 `Movie.price` 的時候，不必修改 `Movie.init(title:priceCode:)` signature
    /// 不會讓使用到建構子的 client code 需要改動，雖然在我們目前的案例中，只有 test case 是唯一的 client, 但我覺得實際的場景中
    /// 有可能會發生到更多的 client code 使用舊的建構子，更能體現到建立 `setPriceCode()` 的好處。
    ///
    /// 因為原本 `Movie.priceCode` 也是 private 的, 上個 commit 使用 `Self Encapsulate Field (171)` 去建立 `getPricecode` 的時候，
    /// 改動的 code 也被限制在 `Movie` 這個 class 中。只要我們在上個 commit 有去檢查 `Movie` class 中對 `Movie.priceCode` 的調用, 改成 `getPricecode`
    /// 在這個 commit 中，我們就只要修改 `setPriceCode()` 和 `getPricecode` 的實作，code base 的其他部分，並不會發現我們已經將原本的 `priceCode` 替換成
    /// `Price` class 的子類，測試和其他的 client 都不會 broken 然後我們就可以在下個 commit, 搬移我們的 typed code, 準備運用 `Replace Conditional With Polymorphism (255)` 去掉骯髒的 switch.
    public func setPriceCode(_ priceCode: PriceCode) {
        switch priceCode {
        case .regular:
            price = RegularPrice()
        case .newRelease:
            price = NewReleasePrice()
        case .childrens:
            price = ChildrensPrice()
        }
    }
    
    public func getPriceCode() -> PriceCode {
        return price.getPriceCode()
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
