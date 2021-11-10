//
//  GamesViewController.swift
//  GameLine
//
//  Created by 霍一帆 on 11/3/21.
//

import UIKit
import Parse
import AlamofireImage

class GamesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    
    
    @IBOutlet weak var tableView: UITableView!
   
    var games = [[String:Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let url = URL(string: "https://api.rawg.io/api/games?key=f08841d43c5348fbbfe5f20d5964fb83&dates=2019-09-01,2019-09-30&platforms=18,1,7")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
             // This will run when the network request returns
             if let error = error {
                    print(error.localizedDescription)
             } else if let data = data {
                    let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]

                    // TODO: Get the array of movies
                    // TODO: Store the movies in a property to use elsewhere
                    // TODO: Reload your table view data
                 self.games = dataDictionary["results"] as! [[String:Any]]
                 
                 self.tableView.reloadData()

             }
        }
        task.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "GameCell") as! GameCell
        
        let game = games[indexPath.row]
        let title = game["name"] as! String
        let synopsis = game["rating"] as! Double
        
        
        cell.titleLabel.text = title
        cell.synopsisLabel.text = "Rating(Out of 5): \(synopsis)"
        
        let posterPath = game["background_image"] as! String
        let posterUrl = URL(string: posterPath)
        
        cell.posterView.af.setImage(withURL: posterUrl!)
        
        
        return cell
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
