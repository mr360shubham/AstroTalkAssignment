//
//  MovieListTableViewCell.swift
//  AstrotalkAssisgnment
//
//  Created by Shubham Baliyan on 10/07/24.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    // MARK: - @IBOutlet
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieYearLabel: UILabel!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUi()
    }
    
    // MARK: - Setup Methods
    func setupUi(){
        movieImageView.contentMode = .scaleAspectFill
    }
    
    func configure(with movie: Movie){
        
        if let poster = movie.Poster {
                    loadImage(from: poster) { [weak self] image in
                        self?.movieImageView.image = image
                    }
                } else {
                    movieImageView.image = UIImage(systemName: "photo")
                }
        
        
        movieTitleLabel.text = movie.Title
        movieYearLabel.text = movie.Year
        setupUi()
    }
    
    private func loadImage(from url: String, completion: @escaping (UIImage?) -> Void) {
            guard let imageURL = URL(string: url) else {
                completion(UIImage(systemName: "photo"))
                return
            }
            
            URLSession.shared.dataTask(with: imageURL) { data, _, error in
                if let error = error {
                    print("Failed to load image: \(error)")
                    DispatchQueue.main.async {
                        completion(UIImage(systemName: "photo"))
                    }
                    return
                }
                
                guard let data = data, let image = UIImage(data: data) else {
                    DispatchQueue.main.async {
                        completion(UIImage(systemName: "photo"))
                    }
                    return
                }
                
                DispatchQueue.main.async {
                    completion(image)
                }
            }.resume()
        }
}
