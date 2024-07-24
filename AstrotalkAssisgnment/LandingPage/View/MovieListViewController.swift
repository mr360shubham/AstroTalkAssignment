

import UIKit

class MovieListViewController: UIViewController {
    
    // MARK: - Properties
    private var viewModel = MoviieViewModel()
    
    // MARK: - @IBOutlet
    @IBOutlet weak var MovieListTableView: UITableView!
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchMovies()
        setupTableView()
        setupBindings()
        
    }
    
    // MARK: - Setup Methods
    private func setupTableView(){
        MovieListTableView.register(UINib(nibName: "MovieListTableViewCell", bundle: nil), forCellReuseIdentifier: "MovieListTableViewCell")
        MovieListTableView.delegate = self
        MovieListTableView.dataSource = self
    }
    
    private func setupBindings(){
        viewModel.onMoviefetched = {[weak self] in
            self?.MovieListTableView.reloadData()
        }
    }
    
    
}

// MARK: - TABLEVIEW DELGATE AND DATASOURCE

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = MovieListTableView.dequeueReusableCell(withIdentifier: "MovieListTableViewCell", for: indexPath) as? MovieListTableViewCell else{return UITableViewCell()}
        let movie = viewModel.movies[indexPath.row]
        cell.configure(with: movie)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Movies"
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
