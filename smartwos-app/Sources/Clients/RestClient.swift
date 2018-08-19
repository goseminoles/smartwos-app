import Foundation
import Alamofire

// Singleton implemented using enum
enum RestClient {

  case shared

  /// Get request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func get(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.get, parameters: parameters)
  }

  /// Head request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func head(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.head, parameters: parameters)
  }

  /// Post request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func post(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.post, parameters: parameters)
  }

  /// Put request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func put(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.put, parameters: parameters)
  }

  /// Patch request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func patch(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.patch, parameters: parameters)
  }

  /// Delete request
  /// - parameter path: The path in addition to the host and base path.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  public func delete(path: String, parameters: Parameters? = nil) -> DataRequest {
    return request(path: path, method: HTTPMethod.delete, parameters: parameters)
  }

  /// Creates a `DataRequest` using the default `SessionManager` to retrieve the contents of the
  // specified `path`, `method`, `parameters`, `encoding` and `headers`.
  ///
  /// - parameter path: The path appended to the host and base path.
  /// - parameter method: The HTTP method.
  /// - parameter parameters: The parameters. `nil` by default.
  ///
  /// - returns: The created `DataRequest`.
  fileprivate func request(path: String, method: HTTPMethod, parameters: Parameters? = nil)
          -> DataRequest {
    return Alamofire.request(
        self.endpoint(path: path),
        method: method,
        parameters: parameters,
        encoding: URLEncoding.default,
        headers: self.headers())
  }

  // Create headers
  fileprivate func headers() -> [String: String] {
    let sharedConfig = ConfigManager.shared()
    let base64EncodedCredential =
        "\(sharedConfig.SmartwosCoreUser):\(sharedConfig.SmartwosCorePassword)"
            .data(using: String.Encoding.utf8)?
            .base64EncodedString() ?? ""

    let headers = [
      "Authorization": "Basic \(base64EncodedCredential)"
    ]
    return headers
  }

  // Create endpoint
  fileprivate func endpoint(path: String) -> URL {
    let sharedConfig = ConfigManager.shared()

    let url = URL(string: sharedConfig.SmartwosCoreHOST)?
        .appendingPathComponent(sharedConfig.SmartwosCoreBasePath)
        .appendingPathComponent(path)

    return url!
  }
}

