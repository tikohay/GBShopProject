//
//  RemoveReview.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

class RemoveReview: AbstractRequestFactory {
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

extension RemoveReview: RemoveReviewRequestFactory {
    func getRemoveReview(idComment: Int,
                         completionHandler: @escaping (AFDataResponse<RemoveReviewResult>) -> Void) {
        let requestModel = RemoveReviewRequest(baseUrl: baseUrl,
                                               idComment: idComment)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension RemoveReview {
    struct RemoveReviewRequest: RequestRouter {
        var baseUrl: URL
        var method: HTTPMethod = .post
        var path: String = "removeReview"
        
        var idComment: Int
        
        var parameters: Parameters? {
            return [
                "id_comment": idComment
            ]
        }
    }
}
