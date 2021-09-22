//
//  AddProductToBasket.swift
//  GBShop
//
//  Created by Karahanyan Levon on 17.09.2021.
//

import Alamofire

class AddProductToBasket: AbstractRequestFactory {
    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://salty-bastion-35523.herokuapp.com")!
    
    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension AddProductToBasket: AddProductToBasketRequestFactory {
    
    func addProductToBasket(productId: Int, quantity: Int, completionHandler: @escaping (AFDataResponse<AddProductToBasketResult>) -> Void) {
        let requestModel = AddProductToBasketRequest(baseUrl: baseUrl,
                                                     productId: productId,
                                                     quantity: quantity)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension AddProductToBasket {
    struct AddProductToBasketRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "addToBasket"
        
        var productId: Int
        var quantity: Int
        
        var parameters: Parameters? {
            return [
                "id_product": productId,
                "quantity": quantity
            ]
        }
    }
}
