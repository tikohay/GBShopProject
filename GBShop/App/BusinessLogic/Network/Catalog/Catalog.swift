//
//  Catalog.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import Foundation
import Alamofire

class Catalog: AbstractRequestFactory {

    let errorParser: AbstractErrorParser
    let sessionManager: Session
    let queue: DispatchQueue
    let baseUrl = URL(string: "https://raw.githubusercontent.com/GeekBrainsTutorial/online-store-api/master/responses/")!

    init(
        errorParser: AbstractErrorParser,
        sessionManager: Session,
        queue: DispatchQueue = DispatchQueue.global(qos: .utility)) {
        self.errorParser = errorParser
        self.sessionManager = sessionManager
        self.queue = queue
    }
}

extension Catalog: CatalogRequestFactory {
    func getCatalog(pageNumber: Int, categoryId: Int, completionHandler: @escaping (AFDataResponse<[CatalogProductResult]>) -> Void) {
        let requestModel = CatalogRequest(baseUrl: baseUrl, categoryId: categoryId, pageNumber: pageNumber)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalog {
    struct CatalogRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "catalogData.json"

        var categoryId: Int
        var pageNumber: Int
        
        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId
            ]
        }
    }
}

