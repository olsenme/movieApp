//
//  MoviesViewController.swift
//  movieApp
//
//  Created by Meagan Olsen on 10/19/19.
//  Copyright © 2019 kjokougar51. All rights reserved.
//

import UIKit
import AlamofireImage

class MoviesViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MovieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.row]
        let title = movie["title"] as! String
        let synopsis = movie["overview"] as! String
        cell.titleLabel.text = title
        cell.titleLabel.sizeToFit()
        cell.synopsisLabel.text = synopsis
        cell.synopsisLabel.sizeToFit()
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseUrl+posterPath)!
        
        cell.posterView.af_setImage(withURL: posterUrl)
      
        return cell
    }

    @IBOutlet var tableView: UITableView!
    
    var movies: [[String:Any]] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        retrieveMovies()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.rowHeight = 250
        
    }
    
    // MARK: -Private Functions
    
    private func retrieveMovies(){

        let url = URL(string: "https://api.themoviedb.org/3/movie/now_playing?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url) { (data, response, error) in
           // This will run when the network request returns
           if let error = error {
              print(error.localizedDescription)
           } else if let data = data,
            let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
            self.movies = dataDictionary["results"] as! [[String:Any]]
            self.tableView.reloadData()

              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

           }
        }
        task.resume()
        }
        
        // This will run when the network request returns
          
    
            
           // self.movies = data[] as! [[String:Any]]
            
            
              // TODO: Get the array of movies
              // TODO: Store the movies in a property to use elsewhere
              // TODO: Reload your table view data

        


        

        // Do any additional setup after loading the view.

    

    
    // MARK: - Navigation
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
       //find selected movie
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)!
        let movie = movies[indexPath.row]
        //pass selected movie to view controller
        let detailsViewController = segue.destination as! MovieDetailsViewController
        detailsViewController.movie = movie;
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
}
    


