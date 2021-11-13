//
//  AddReview.swift
//  GBShop
//
//  Created by Karahanyan Levon on 14.09.2021.
//

import Alamofire

class AddReview: AbstractRequestFactory {
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

extension AddReview: AddReviewRequestFactory {
    func getAddReview(idUser: Int,
                      text: String,
                      completionHandler: @escaping (AFDataResponse<AddReviewResult>) -> Void) {
        let requestModel = AddReviewRequest(baseUrl: baseUrl,
                                            idUser: idUser,
                                            text: text)
        self.request(request: requestModel,
                     completionHandler: completionHandler)
    }
}

extension AddReview {
    struct AddReviewRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .post
        let path: String = "addReview"
        
        var idUser: Int
        var text: String
        
        var parameters: Parameters? {
            return [
                "id_user": idUser,
                "text": text
            ]
        }
    }
}

