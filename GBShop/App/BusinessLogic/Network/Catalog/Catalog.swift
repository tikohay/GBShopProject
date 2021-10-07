//
//  Catalog.swift
//  GBShop
//
//  Created by Karahanyan Levon on 03.09.2021.
//

import Alamofire

class Catalog: AbstractRequestFactory {
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

extension Catalog: CatalogRequestFactory {
    func getCatalog(pageNumber: Int,
                    categoryId: Int,
                    category: String,
                    completionHandler: @escaping (AFDataResponse<[CatalogProductResult]>) -> Void) {
        let requestModel = CatalogRequest(baseUrl: baseUrl,
                                          categoryId: categoryId,
                                          pageNumber: pageNumber,
                                          category: category)
        self.request(request: requestModel, completionHandler: completionHandler)
    }
}

extension Catalog {
    struct CatalogRequest: RequestRouter {
        let baseUrl: URL
        let method: HTTPMethod = .get
        let path: String = "products"

        var categoryId: Int
        var pageNumber: Int
        var category: String

        var parameters: Parameters? {
            return [
                "page_number": pageNumber,
                "id_category": categoryId,
                "category": category
            ]
        }
    }
}

