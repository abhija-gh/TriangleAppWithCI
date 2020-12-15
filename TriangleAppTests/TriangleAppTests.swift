//
//  TriangleAppTests.swift
//  TriangleAppTests
//
//  Created by Abhijana Agung Ramanda on 12/12/20.
//

import XCTest
@testable import TriangleApp

class TriangleAppTests: XCTestCase {
  
  override func setUpWithError() throws {
    // Put setup code here. This method is called before the invocation of each test method in the class.
  }
  
  override func tearDownWithError() throws {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
  }
  
  func testExample() throws {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
  }
  
  func testPerformanceExample() throws {
    // This is an example of a performance test case.
    self.measure {
      // Put the code you want to measure the time of here.
    }
  }
  
  func testInvalidInputSides() {
    XCTAssertThrowsError(try detectTriangle(-1, 2, 3)) { error in
      XCTAssertEqual(error as? TriangleError, TriangleError.invalidInput)
    }
  }
  
  // MARK: - Test Triangle
  func testDetectEquilateralTriangle() {
    XCTAssertEqual(try detectTriangle(2, 2, 2), "Segitiga Sama Sisi")
  }
  
  func testDetectIsoscelesTriangle() {
    XCTAssertEqual(try detectTriangle(8, 8, 10), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(8, 10, 8), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(8, 10, 10), "Segitiga Sama Kaki")
    XCTAssertEqual(try detectTriangle(10, 8, 10), "Segitiga Sama Kaki")
  }
  
  func testDetectRandomTriangle() {
    XCTAssertEqual(try detectTriangle(5, 7, 9), "Segitiga Sembarang")
  }
  
  func testInequalityTriangle() {
    XCTAssertThrowsError(try detectTriangle(4, 1, 2)) { error in
      XCTAssertEqual(error as? TriangleError, TriangleError.inequalityInput)
    }
    
    XCTAssertThrowsError(try detectTriangle(5, 1, 3)) { error in
      XCTAssertEqual(error as? TriangleError, TriangleError.inequalityInput)
    }
  }
  
  func testDetectPythagorasTriangle() {
    XCTAssertEqual(try detectTriangle(6, 8, 10), "Segitiga Siku-siku")
  }
  
  // MARK: - Functions
  /*
    Skenario
    
    1. Tiga panjang segitiga (sisi a, sisi b, sisi c) telah diterima.
       a. Bila salah satu sisi bernilai < 1, maka gagal.
       b. Bila salah satu sisi tidak bernilaikan integer, maka gagal.
       c. Bila sisi a + b bernilai <= c, maka gagal.
   
    2.  Mendeteksi segitiga:
       a. Kembalikan “Segitiga Sama Sisi” bila a, b, dan c sama.
       b. Kembalikan “Segitiga Sama Kaki” bila:
         Sisi a, b sama, namun c berbeda.
         Sisi a, c sama, namun b berbeda.
         Sisi b, c sama, namun a berbeda.
       c. Kembalikan “Segitiga Sembarang” bila a, b dan c berbeda panjang.
   
    3.  Pendeteksian segitiga selesai.
   
   */
  func detectTriangle(
    _ sideA: Int,
    _ sideB: Int,
    _ sideC: Int
  ) throws -> String {
    
//  Terlihat konyol, tpi memang spt itu (Minimal effort supaya pengujian lolos)
//    if sideA < 1 {
//      throw TriangleError.invalidInput
//    }
    
    let sides = [sideA, sideB, sideC].sorted()
    
    for side in sides {
      if side < 0 {
        throw TriangleError.invalidInput
      }
    }
    
    if sides[1] + sides[0] <= sides[2] {
      throw TriangleError.inequalityInput
    }
//    if sideA == sideB && sideA == sideC {
//    if (sideA, sideA) == (sideB, sideC) {
    else if sides[0] == sides[1] && sides[0] == sides[2] {
      return "Segitiga Sama Sisi"
    }
// Sederhanakan perbandingan ini !
//    else if sideA == sideB || sideA == sideC || sideB == sideC {
    
    // Dengan cara mengurutkan panjang sisi,
    // sehingga sisi dengan panjang yang mirip itu saling berdekatan
    // (1,2,1) -> (1,1,2) yakin bahwa sama kaki tanpa cek sisi ketiga
    // apakah A = B / B = C
    else if sides[0] == sides[1] || sides[1] == sides[2] {
      return "Segitiga Sama Kaki"
    }
    else if Double( (sides[0] * sides[0] + sides[1] * sides[1]) ).squareRoot() == Double(sides[2]) {
      return "Segitiga Siku-siku"
    }
    else {
      return "Segitiga Sembarang"
    }
  }
  
  enum TriangleError: Error {
    case invalidInput, inequalityInput
  }
  
}
