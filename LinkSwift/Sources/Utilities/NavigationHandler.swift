import UIKit

class NavigationHandler {
    static func initNavigation() -> UIViewController {
        let homeScreen = MainViewController(nibName: "MainViewController", bundle: nil)
        let offersScreen = OffersViewController(nibName: "OffersViewController", bundle: nil)
        let messagesScreen = MessagesViewController(nibName: "MessagesViewController", bundle: nil)
        let favoritesScreen = FavoritesViewController(nibName: "FavoritesViewController", bundle: nil)
        let profileScreen = ProfileViewController(nibName: "ProfileViewController", bundle: nil)
        
        homeScreen.tabBarItem.title = "Accueil"
        homeScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        homeScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        homeScreen.tabBarItem.image = UIImage(systemName: "house.fill")
        homeScreen.tabBarItem.image = homeScreen.tabBarItem.image?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        homeScreen.tabBarItem.selectedImage = homeScreen.tabBarItem.selectedImage?.withTintColor(UIColor.tintColor, renderingMode: .alwaysOriginal)
        
        offersScreen.tabBarItem.title = "Offres"
        offersScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        offersScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        offersScreen.tabBarItem.image = UIImage(systemName: "list.bullet.rectangle.fill")
        offersScreen.tabBarItem.image = offersScreen.tabBarItem.image?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        offersScreen.tabBarItem.selectedImage = offersScreen.tabBarItem.selectedImage?.withTintColor(UIColor.tintColor, renderingMode: .alwaysOriginal)
        
        messagesScreen.tabBarItem.title = "Messages"
        messagesScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        messagesScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        messagesScreen.tabBarItem.image = UIImage(systemName: "message.fill")
        messagesScreen.tabBarItem.image = messagesScreen.tabBarItem.image?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        messagesScreen.tabBarItem.selectedImage = messagesScreen.tabBarItem.selectedImage?.withTintColor(UIColor.tintColor, renderingMode: .alwaysOriginal)
        
        favoritesScreen.tabBarItem.title = "Favoris"
        favoritesScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        favoritesScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        favoritesScreen.tabBarItem.image = UIImage(systemName: "heart.fill")
        favoritesScreen.tabBarItem.image = favoritesScreen.tabBarItem.image?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        favoritesScreen.tabBarItem.selectedImage = favoritesScreen.tabBarItem.selectedImage?.withTintColor(UIColor.tintColor, renderingMode: .alwaysOriginal)
        
        profileScreen.tabBarItem.title = "Mon Profil"
        profileScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.gray], for: .normal)
        profileScreen.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.tintColor], for: .selected)
        profileScreen.tabBarItem.image = UIImage(systemName: "person.fill")
        profileScreen.tabBarItem.image = profileScreen.tabBarItem.image?.withTintColor(UIColor.gray, renderingMode: .alwaysOriginal)
        profileScreen.tabBarItem.selectedImage = profileScreen.tabBarItem.selectedImage?.withTintColor(UIColor.tintColor, renderingMode: .alwaysOriginal)
        
        let navigationController: UITabBarController = UITabBarController()
        navigationController.viewControllers = [
            homeScreen,
            offersScreen,
            messagesScreen,
            favoritesScreen,
            profileScreen
        ]
        
        navigationController.tabBar.backgroundColor = UIColor.white
        return navigationController
    }
}
