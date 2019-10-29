//
//  MovieGridViewController.swift
//  movieApp
//
//  Created by Meagan Olsen on 10/27/19.
//  Copyright © 2019 kjokougar51. All rights reserved.
//

import UIKit
import AlamofireImage

class MovieGridViewController: UIViewController,UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieGridCell", for: indexPath) as! MovieGridCell
       
        let movie = movies[indexPath.item]
        let baseUrl = "https://image.tmdb.org/t/p/w185"
        let posterPath = movie["poster_path"] as! String
        let posterUrl = URL(string:baseUrl+posterPath)!
              
        /*cell.posterView.af_setImage(withURL: posterUrl)*/
        return cell
    }
    
    
   
    
    var movies: [[String:Any]] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // posterView.delegate = self
        //posterView.dataSource = self
        
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/297762/similar?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url) { (data, response, error) in
        // This will run when the network request returns
        if let error = error {
                     print(error.localizedDescription)
                  }else if let data = data,
        let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]{
        self.movies = dataDictionary["results"] as! [[String:Any]]
        print(self.movies)
    

                  }
               }
               task.resume()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
