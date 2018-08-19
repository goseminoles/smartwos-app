import Foundation
import Alamofire

// Singleton implemented using enum
enum RestClient {

  case shared

  public func get(path: String, parameters: Parameters? = nil) -> DataRequest {
    return Alamofire.request(
        self.endpoint(path: path),
        method: .get,
        parameters: parameters,
        encoding: URLEncoding.default,
        headers: self.headers())
  }


  func headers() -> [String: String] {
    let sharedConfig = ConfigManager.shared()
    let base64EncodedCredential =
        "\(sharedConfig.SmartwosCoreUser):\(sharedConfig.SmartwosCorePassword)"
        .data(using: String.Encoding.utf8)?
        .base64EncodedString() ?? ""

    let headers = [
      "Authorization": "Basic \(base64EncodedCredential)",
      "Accept": "application/json",
      "Content-Type": "application/json"
    ]
    return headers
  }

  func endpoint(path: String) -> URL {
    let sharedConfig = ConfigManager.shared()

    let url = URL(string: sharedConfig.SmartwosCoreHOST)?
        .appendingPathComponent(sharedConfig.SmartwosCoreBasePath)
        .appendingPathComponent(path)

    return url!
  }
}

