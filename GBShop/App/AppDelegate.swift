//
//  AppDelegate.swift
//  GBShop
//
//  Created by Karahanyan Levon on 26.08.2021.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    let requestFactory = RequestFactory()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
//        let auth = requestFactory.makeAuthRequestFactory()
//        auth.login(userName: "Somebody", password: "mypassword") { response in
//            switch response.result {
//            case .success(let login):
//                print(login)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let logout = requestFactory.makeLogoutRequestFactory()
//        logout.logout(id: 123) { response in
//            switch response.result {
//            case .success(let logout):
//                print(logout)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let registration = requestFactory.makeRegistrationRequestFactory()
//        let registrationData = RegistrationData(id: 123,
//                                                username: "Somebody",
//                                                password: "mypassword",
//                                                email: "some@some.ru",
//                                                gender: Gender.man.rawValue,
//                                                creditCard: "9872389-2424-234224-234",
//                                                bio: "This is good! I think I will switch to another language")
//
//        registration.register(registrationData: registrationData) { response in
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let updateUser = requestFactory.makeUpdateUserRequestFactory()
//        let updateUserData = UpdateUserData(id: 123,
//                                            username: "Somebody",
//                                            password: "mypassword",
//                                            email: "some@some.ru",
//                                            gender: Gender.man.rawValue,
//                                            creditCard: "9872389-2424-234224-234",
//                                            bio: "This is good! I think I will switch to another language")
//
//        updateUser.updateUser(updateUserData: updateUserData) { response in
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let catalog = requestFactory.makeCatalogRequestFactory()
//
//        catalog.getCatalog(pageNumber: 1, categoryId: 1) { response in
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }
//
//        let product = requestFactory.makeProductRequestFactory()
//        product.getProduct(productId: 1) { response in
//            switch response.result {
//            case .success(let result):
//                print(result)
//            case .failure(let error):
//                print(error.localizedDescription)
//            }
//        }

        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

