//
//  MovieDetailViewController.swift
//  Flicks
//
//  Created by Utkarsh Sengar on 4/1/17.
//  Copyright © 2017 Area42. All rights reserved.
//

import UIKit
import AFNetworking

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var bigPosterImage: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    @IBOutlet weak var scroll: UIScrollView!
    @IBOutlet weak var infoView: UIView!
    
    var movie: NSDictionary!
    var defaultPoint: CGPoint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scroll.contentSize = CGSize(width: scroll.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        movieTitle.text = movie["title"] as? String
        movieOverview.text = movie["overview"] as? String
        movieOverview.sizeToFit()
    
        defaultPoint = self.infoView.frame.origin
        self.infoView.frame.origin = CGPoint(x: infoView.frame.origin.x, y: UIScreen.main.bounds.maxY - infoView.frame.height)
        
        let baseUrl = "https://image.tmdb.org/t/p/w500"
        if let posterPath = movie["poster_path"] as? String{
            let imgUrl = NSURL(string: baseUrl + posterPath)
            bigPosterImage.setImageWith(imgUrl as URL!)
        }
        
        UIView.animate(withDuration: 0.2, delay: 0.3, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
            self.infoView.frame.origin = CGPoint(x: self.infoView.frame.origin.x, y: self.infoView.frame.origin.y - 60)
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: 1, usingSpringWithDamping: 0.8, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {
                self.infoView.frame.origin = self.defaultPoint
            }) { _ in
            }
        }
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
