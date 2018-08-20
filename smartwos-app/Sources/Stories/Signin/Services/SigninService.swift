import Foundation
import Alamofire
import RxSwift

class SigninService {

  typealias Signin = Models.Signin

  enum SigninFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
    case internalServerError = 500
  }

  let client = RestClient.shared

  func siginin(by passkey: String) -> Observable<Signin> {

    let params: Parameters = ["passkey": passkey]

    return Observable.create { observer -> Disposable in
      self.client.post(path: "passkeys/login", parameters: params)
          .responseJSON { response in
            switch response.result {
            case .success:
              do {
                guard let data = response.data else {
                  observer.onError(response.error ?? SigninFailureReason.notFound)
                  return
                }
                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let signin = try jsonDecoder.decode(Signin.self, from: data)

                observer.onNext(signin)
              } catch {
                observer.onError(error)
              }
            case .failure(let error):
              if let statusCode = response.response?.statusCode,
                 let reason = SigninFailureReason(rawValue: statusCode) {
                observer.onError(reason)
              }
              observer.onError(error)
            }
          }

      return Disposables.create()
    }
  }

}
