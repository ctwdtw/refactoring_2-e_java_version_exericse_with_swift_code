import XCTest
import refactoring_java_ed

final class refactoring_java_edTests: XCTestCase {
    func testStatement() {
        // given
        let bigCo = makeCustomer(name: "BigCo")
        let expected = """
Rental Record for BigCo
  Movie1  2.0
  Movie2  5.0
  Movie3  6.0
  Movie4  1.5
  Movie5  3.0
Amount owed is 17.5
You earned 6 frequent renter points
"""
        // when
        let result = bigCo.statement()
        // then
        XCTAssertEqual(result, expected)
    }
    
    private func makeCustomer(name: String) -> Customer {
        let customer = Customer(name: name)
        customer.addRental(Rental(movie: Movie(title: "Movie1", priceCode: .regular), daysRented: 1))
        customer.addRental(Rental(movie: Movie(title: "Movie2", priceCode: .regular), daysRented: 4))
        customer.addRental(Rental(movie: Movie(title: "Movie3", priceCode: .newRelease), daysRented: 2))
        customer.addRental(Rental(movie: Movie(title: "Movie4", priceCode: .childrens), daysRented: 1))
        customer.addRental(Rental(movie: Movie(title: "Movie5", priceCode: .childrens), daysRented: 4))
        return customer
    }
}
