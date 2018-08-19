import Foundation
import Alamofire
import RxSwift

class LabelService {

  enum GetLabelItemsFailureReason: Int, Error {
    case unAuthorized = 401
    case notFound = 404
    case internalServerError = 500
  }

  let client = RestClient.shared

  func getLabelItems(for orderId: String) -> Observable<[LabelItem]> {
    return Observable.create { observer -> Disposable in
      self.client.get(path: "mocked/labels/items/\(orderId)", parameters: nil)
          .responseJSON { response in
            switch response.result {
            case .success:
              do {
                guard let data = response.data else {
                  observer.onError(response.error ?? GetLabelItemsFailureReason.notFound)
                  return
                }

                let jsonDecoder = JSONDecoder()
                jsonDecoder.keyDecodingStrategy = .convertFromSnakeCase
                let labelItems = try jsonDecoder.decode([LabelItem].self, from: data)
                observer.onNext(labelItems)
              } catch {
                observer.onError(error)
              }
            case .failure(let error):
              if let statusCode = response.response?.statusCode,
                 let reason = GetLabelItemsFailureReason(rawValue: statusCode) {
                observer.onError(reason)
              }
              observer.onError(error)
            }
          }

      return Disposables.create()
    }
  }

}
