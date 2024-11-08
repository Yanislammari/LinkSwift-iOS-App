import Foundation

class PostService {
    static var posts: [Post]? = nil
    
    static func fetchPosts(completion: @escaping () -> Void) {
        let url: URL = URL(string: "\(Api.baseUrl)/posts")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let downloadedData = data else {
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: downloadedData) else{
                return
            }
            guard let postsArray = json as? [[String : Any]] else {
                return
            }
            let posts = postsArray.compactMap(Post.fromJSON(dict:))
            DispatchQueue.main.async {
                self.posts = posts
                completion()
            }
        }
        task.resume()
    }
}
