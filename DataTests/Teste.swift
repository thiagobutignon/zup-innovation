//
//  Teste.swift
//  DataTests
//
//  Created by Thiago B Claramunt on 15/09/21.
//

import Foundation
import XCTest

enum ViewResult: Decodable, Equatable {
    case food(FoodDelivery)
    case package(PackageDelivery)
    case passenger(PassengerDelivery)
    
    enum CodingKeys: CodingKey, CaseIterable {
        case food
        case package
        case passenger
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        if let value = try container.decodeIfPresent(FoodDelivery.self, forKey: .food) {
            self = ViewResult.food(value)
            return
        }
        
        if let value = try container.decodeIfPresent(PackageDelivery.self, forKey: .package) {
            self = ViewResult.package(value)
            return
        }
        
        if let value = try container.decodeIfPresent(PassengerDelivery.self, forKey: .passenger) {
            self = ViewResult.passenger(value)
            return
        }
        
        throw DecodingError.valueNotFound(Self.self, DecodingError.Context(codingPath: CodingKeys.allCases, debugDescription: "food/package/passenger not found"))
    }
}

struct FoodDelivery: Codable, Equatable {
    struct Order: Codable, Equatable {
        let name: String
        let cost: String
    }
    let date: String
    let orders: [Order]
    let restaurantName: String
    let totalCost: String
}

struct PackageDelivery: Codable, Equatable {
    let date: String
    let size: String
    let totalCost: String
    let weight: String
}

struct PassengerDelivery: Codable, Equatable {
    struct CarType: Codable, Equatable {
        let name: String
        let distanceFare: String
        let timeFare: String
    }
    let carType: CarType
    let date: String
    let distance: String
    let time: String
    let totalCost: String
}



class Teste: XCTestCase {

    
    func testDecodingArrayWithPassengerDeliverySucceeds() throws {
        
        let givenJsonData = #"""
            [
            {
            "food": {
            "date": "2020-01-01",
            "restaurantName": "Restaurant",
            "totalCost": "8.00",
            "orders": [
            {
            "name": "Pizza",
            "cost": "100"
            }
            ]
            }
            },
            {
            "passenger": {
            "carType": {
            "name": "SUV",
            "distanceFare": "1.00",
            "timeFare": "1.00"
            },
            "date": "2020-01-01",
            "distance": "2 km",
            "time": "10 min",
            "totalCost": "8.00"
            }
            },
            {
            "package": {
            "date": "2020-01-01",
            "totalCost": "8.00",
            "weight": "1 kg",
            "size": "SMALL"
            }
            }
            ]
    """#.data(using: .utf8)!
        let result = try JSONDecoder().decode([ViewResult].self, from: givenJsonData)
        let expected: [ViewResult] = [
            ViewResult.food(FoodDelivery(
                date: "2020-01-01",
                orders: [
                    FoodDelivery.Order(name: "Pizza", cost: "100")
                ],
                restaurantName: "Restaurant",
                totalCost: "8.00"
            )),
            ViewResult.passenger(PassengerDelivery(
                carType: PassengerDelivery.CarType(
                    name: "SUV",
                    distanceFare: "1.00",
                    timeFare: "1.00"
                ),
                date: "2020-01-01",
                distance: "2 km",
                time: "10 min",
                totalCost: "8.00"
            )),
            ViewResult.package(PackageDelivery(
                date: "2020-01-01",
                size: "SMALL",
                totalCost: "8.00",
                weight: "1 kg"
            ))
        ]
        XCTAssertEqual(result, expected)
    }
    
    
    
    func testDecodingUnknownOrderItemsThrowsAnError() throws {
        let givenJsonData = #"""
            [
            "unknownDelivery": "unknownValue"
            ]
    """#.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode([ViewResult].self, from: givenJsonData))
    }
    
    func testDecodingEmptyArraySucceeds() throws {
        let givenJsonData = #"""
            []
    """#.data(using: .utf8)!
        let result = try JSONDecoder().decode([ViewResult].self, from: givenJsonData)
        let expected: [ViewResult] = []
        XCTAssertEqual(result, expected)
    }
    
    func testDecodingFoodDeliveryWithoutRestaurantThrowsAnError() throws {
        let givenJsonData = #"""
            [
            {
            "food": {
            "date": "2020-01-01",
            "totalCost": "8.00",
            "orders": [
            {
            "name": "Pizza",
            "cost": "100"
            }
            ]
            }
            }
            ]
    """#.data(using: .utf8)!
        XCTAssertThrowsError(try JSONDecoder().decode([ViewResult].self, from: givenJsonData))
    }
}
