//
//  MainTabBarController.swift
//  GBShop
//
//  Created by Karahanyan Levon on 25.09.2021.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        tabBar.barTintColor = .blue
        
        let test = TestViewController()
        let test2 = Test2ViewController()
        let userInformationViewController = UserInformationViewController()
        
        viewControllers = [userInformationViewController, test, test2]
    }
}

/*
 tabBar.barTintColor = .white
 
 let listViewController = ListViewController()
 let peopleViewController = PeopleViewController()
 
 tabBar.tintColor = #colorLiteral(red: 0.5568627451, green: 0.3529411765, blue: 0.968627451, alpha: 1)
 let boldConfiguration = UIImage.SymbolConfiguration(weight: .medium)
 let convImage = UIImage(systemName: "bubble.left.and.bubble.right", withConfiguration: boldConfiguration)!
 let peopleImage = UIImage(systemName: "person.2", withConfiguration: boldConfiguration)!
 
 viewControllers = [
     generateNavigationController(rootViewController: peopleViewController, title: "People", image: peopleImage),
     
     generateNavigationController(rootViewController: listViewController, title: "Conversations", image: convImage)
 ]
}

private func generateNavigationController(rootViewController: UIViewController, title: String, image: UIImage) -> UIViewController {
 let navigationVC = UINavigationController(rootViewController: rootViewController)
 navigationVC.tabBarItem.title = title
 navigationVC.tabBarItem.image = image
 return navigationVC
}
 */
