//
//  AllReviews.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

class AllReviews: AbstractRequestFactory {
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

extension AllReviews: AllReviewsRequestFactory {
    func getAllReviews(productId: Int,
                       completionHandler: @escaping (AFDataResponse<[AllReviewsResult]>) -> Void) {
        let requestModel = AllReviewsRequest(baseUrl: baseUrl,
                                             productId: productId)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension AllReviews {
    struct AllReviewsRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "allReviews"
        
        var productId: Int
        
        var parameters: Parameters? {
            return [
                "product_id": productId
            ]
        }
    }
}
