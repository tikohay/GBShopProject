//
//  DeleteProductFromBasket.swift
//  GBShop
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import Alamofire

class DeleteProductFromBasket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "http://127.0.0.1:8080")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension DeleteProductFromBasket: DeleteProductFromBasketRequestFactory {
    func deleteProductFromBasket(productId: Int, completionHandler: @escaping (AFDataResponse<DeleteProductFromBasketResult>) -> Void) {
        let requestModel = DeleteProductFromBasketRequest(baseUrl:
                                                            baseUrl, productId: productId)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension DeleteProductFromBasket {
    struct DeleteProductFromBasketRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "deleteFromBasket"
        
        var productId: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId
            ]
        }
    }
}
