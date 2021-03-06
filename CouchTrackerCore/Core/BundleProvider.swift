import Foundation

public protocol BundleProvider {
  var bundle: Bundle { get }
}

public protocol LanguageProvider {
  var currentLanguage: SupportedLanguages { get }
}

public final class DefaultBundleProvider: BundleProvider, LanguageProvider {
  private typealias Static = DefaultBundleProvider
  private static let languageKey = "CouchTrackerCoreLanguage"
  public static let instance = DefaultBundleProvider()
  private static var _language: SupportedLanguages = .englishUS
  private static var _bundle = Bundle.couchTrackerCore
  private static var _userDefaults = UserDefaults.standard

  private init() {
    if let languageIdentifier = UserDefaults.standard.string(forKey: Static.languageKey),
      let language = SupportedLanguages(rawValue: languageIdentifier) {
      Static.update(language: language)
    }
  }

  public static func update(userDefaults: UserDefaults) {
    _userDefaults = userDefaults
  }

  public static func update(language: SupportedLanguages) {
    let bundleName = languageBundleName(for: language)

    guard let path = Bundle.couchTrackerCore.path(forResource: bundleName, ofType: "lproj") else { return }

    guard let languageBundle = Bundle(path: path) else { return }
    languageBundle.load()

    Static._bundle = languageBundle

    _userDefaults.set(language.rawValue, forKey: Static.languageKey)

    Static._language = language
  }

  public var bundle: Bundle {
    return Static._bundle
  }

  public var currentLanguage: SupportedLanguages {
    return Static._language
  }

  private static func languageBundleName(for language: SupportedLanguages) -> String {
    switch language {
    case .englishUS: return "en"
    case .portugueseBrazil: return "pt-BR"
    }
  }
}
