import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        
        // Создаём MapViewController
        let mapVC = MapViewController()
        let navController = UINavigationController(rootViewController: mapVC)
        
        window?.rootViewController = navController
        window?.makeKeyAndVisible()
        
        print("✅ SceneDelegate: MapViewController загружен")
    }
}
