//
//  MoviesViewController.swift
//  Flicks
//
//  Created by Utkarsh Sengar on 3/31/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit
import AFNetworking
import MBProgressHUD

class MoviesViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    var endpoint: String = ""
    var movies: [NSDictionary]?
    var netWorkError: UIView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.netWorkError = UIView(frame: CGRect(x: UIScreen.main.bounds.minX, y: UIScreen.main.bounds.minY + 65, width:  UIScreen.main.bounds.width, height: 14))
        self.netWorkError?.backgroundColor = UIColor(red:0.57, green:0.15, blue:0.98, alpha:1.00)
        self.netWorkError?.isHidden = true
        self.view.addSubview(netWorkError!)

        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshControlAction(_:)), for: UIControlEvents.valueChanged)
        tableView.insertSubview(refreshControl, at: 0)
        
        MBProgressHUD.showAdded(to: self.view, animated: true)

        tableView.dataSource = self
        tableView.delegate = self
        makeApiRequest(refreshControl: refreshControl)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        if let movies = movies {
            return movies.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell") as! MovieCell
        let movie = movies![indexPath.row]
        let title = movie["title"] as! String
        let overview = movie["overview"] as! String
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            let imgUrl = NSURL(string: baseUrl + posterPath)
            cell.posterView.setImageWith(imgUrl as URL!)
        }
        
        cell.titleLabel.text = title
        cell.overviewLabel.text = overview
        
        return cell
    }
    
     // MARK: - Navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        
        let movie = movies![(indexPath?.row)!]
        let detailViewController = segue.destination as! MovieDetailViewController
        detailViewController.movie = movie
     }
    
    func refreshControlAction(_ refreshControl: UIRefreshControl) {
        makeApiRequest(refreshControl: refreshControl)
    }
    
    func makeApiRequest(refreshControl: UIRefreshControl){
        let apiKey = "a07e22bc18f5cb106bfe4cc1f83ad8ed"
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(endpoint)?api_key=\(apiKey)")
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = 3
        let request = URLRequest(url: url!)
        let session = URLSession(
            configuration: config,
            delegate: nil,
            delegateQueue: OperationQueue.main
        )
        
        let task : URLSessionDataTask = session.dataTask(with: request,completionHandler: { (dataOrNil, response, error) in
            if error != nil {
                MBProgressHUD.hide(for: self.view, animated: true)
                self.netWorkError?.isHidden = false

                let label = UILabel(frame: CGRect(x: (self.netWorkError?.bounds.minX)!, y: (self.netWorkError?.bounds.maxY)!-12, width: (self.netWorkError?.bounds.width)!, height: 12))
                    
                label.textAlignment = .center
                label.text = "Network Error!"
                label.textColor = UIColor.white
                label.font = label.font.withSize(10)

                self.netWorkError?.addSubview(label)
                refreshControl.endRefreshing()
            } else if let data = dataOrNil {
                if let responseDictionary = try! JSONSerialization.jsonObject(with: data, options:[]) as? NSDictionary {
                    self.netWorkError?.isHidden = true

                    self.movies = responseDictionary["results"] as? [NSDictionary]
                    MBProgressHUD.hide(for: self.view, animated: true)
                    self.tableView.reloadData()
                    refreshControl.endRefreshing()
                }
            }
        });
        task.resume()
        
    }
}
