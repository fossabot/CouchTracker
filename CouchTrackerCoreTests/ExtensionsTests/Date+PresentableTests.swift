@testable import CouchTrackerCore
import XCTest

final class DatePresentableTests: XCTestCase {
  private var userDefaults: UserDefaults!
  private var oldLanguage: SupportedLanguages!

  override func setUp() {
    super.setUp()

    oldLanguage = DefaultBundleProvider.instance.currentLanguage
  }

  override func tearDown() {
    DefaultBundleProvider.update(language: oldLanguage)
    XCTAssertEqual(DefaultBundleProvider.instance.currentLanguage, oldLanguage)
    super.tearDown()
  }

  func testDatePresentable_inPortugueseBrazil() {
    DefaultBundleProvider.update(language: .portugueseBrazil)

    XCTAssertEqual(DefaultBundleProvider.instance.currentLanguage, .portugueseBrazil)

    let date = Date(timeIntervalSince1970: 1_557_187_200) //		2019-05-07 00:00:00 +0000
    let expectedString = "06 de maio"
    XCTAssertEqual(date.shortString(), expectedString)
  }

  func testDatePresentable_inEnglishUS() {
    DefaultBundleProvider.update(language: .englishUS)

    XCTAssertEqual(DefaultBundleProvider.instance.currentLanguage, .englishUS)

    let date = Date(timeIntervalSince1970: 1_557_187_200) //		2019-05-07 00:00:00 +0000
    let expectedString = "May 06"
    XCTAssertEqual(date.shortString(), expectedString)
  }
}
