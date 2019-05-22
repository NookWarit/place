//
//  ViewController.swift
//  Places
//
//  Created by warittha on 19/5/2562 BE.
//  Copyright © 2562 warittha. All rights reserved.
//

import UIKit
class ViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
    
    
    
    @IBOutlet weak var tableview: UITableView!
    
    var Datas = [jsondata]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchJSON();
      
        
    }
    struct jsondata: Decodable {
        let id : Int
        let title : String
        let url : String    }
    // MARK: - Table view data source
    fileprivate func fetchJSON() {
//        let urlString = "https://api.foursquare.com/v2/venues/search?ll=40.7,-74&client_id=NUPAW1HLSM55KLVBCPG2IRJIKUTVMSFQWYMIGEWWQLXR1M1W&client_secret=URPSH0T5CZAMOBREMIYSSN20HMCFE5RVNFU5ULEDZZWQEGZ5&v=201900603"
        let urlString = "https://jsonplaceholder.typicode.com/photos"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            DispatchQueue.main.async {
                if let err = err{
                    print("Error get data from url",err)
                }
            }
            guard let data = data else { return }
            
            do{
                let decoder = JSONDecoder()
                self.Datas = try decoder.decode([jsondata].self, from: data)
                
                self.tableview.reloadData()
            }
            catch
                let jsonErr{
                    print("Error Json",jsonErr)
            }
            
            }.resume()
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Datas.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
         //       let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
       //let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TableViewCell
        let list = Datas[indexPath.row]
        cell.textLabel?.text = list.title
        cell.detailTextLabel?.text = String(list.url)
        
        
        return cell
    }
    

}

