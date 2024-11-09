import UIKit

class MainViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var addPostImageView: UIImageView!
    @IBOutlet weak var searchUserImageView: UIImageView!
    @IBOutlet weak var helloLabel: UILabel!
    @IBOutlet weak var postsTableView: UITableView!
    var posts: [Post] = []
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = self.posts[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "POST_CELL_ID", for: indexPath) as! PostTableViewCell
        cell.reload(with: post)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PostTableViewCell {
            cell.playVideoIfVisible()
        }
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if let cell = cell as? PostTableViewCell {
            cell.stopVideoIfNotVisible()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = self.posts[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
        let addPostImageViewTapGesture = UITapGestureRecognizer(target: self, action: #selector(self.onTapAddPostImageView))
        self.addPostImageView.isUserInteractionEnabled = true
        self.addPostImageView.addGestureRecognizer(addPostImageViewTapGesture)
        
        helloLabel.text = "\(helloLabel.text!) \(UserService.userConnected!.firstname) !"
        
        let cellNib = UINib(nibName: "PostTableViewCell", bundle: nil)
        self.postsTableView.register(cellNib, forCellReuseIdentifier: "POST_CELL_ID")
        self.postsTableView.dataSource = self
        self.postsTableView.delegate = self
        
        self.postsTableView.rowHeight = UITableView.automaticDimension
        self.postsTableView.estimatedRowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PostService.fetchPosts {
            self.posts = PostService.posts ?? []
            self.postsTableView.reloadData()
        }
    }
    
    @objc func onTapAddPostImageView() {
        self.navigationController?.pushViewController(AddPostViewController(), animated: true)
    }
}
