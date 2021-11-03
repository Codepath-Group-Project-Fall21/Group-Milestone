//
//  GamesViewController.swift
//  GameLine
//
//  Created by 霍一帆 on 11/3/21.
//

import UIKit
import Parse

class GamesViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func onLogoutButton(_ sender: Any) {
        PFUser.logOut()
            
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(identifier: "LoginViewController")
            
        guard let windomScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windomScene.delegate as? SceneDelegate else {return}
            
        delegate.window?.rootViewController = loginViewController
    }
    
}
