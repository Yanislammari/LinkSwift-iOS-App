import Foundation

class UserService {
    static var userId: UUID? = nil
    static var user: User? = nil
    static var userConnected: User? = nil;
        
    static func getUserIdByToken(token: String, completion: @escaping () -> Void) {
        let url: URL = URL(string: "\(Api.baseUrl)/auth")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return
            }
            DispatchQueue.main.async {
                if let userId = json["userId"] as? String {
                    self.userId = UUID(uuidString: userId)
                }
                completion()
            }
        }
        task.resume()
    }
    
    static func getUserById(id: UUID, completion: @escaping () -> Void) {
        let url: URL = URL(string: "\(Api.baseUrl)/users/\(id)")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task: URLSessionDataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return
            }
            guard let data = data else {
                return
            }
            guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String : Any] else {
                return
            }
            DispatchQueue.main.async {
                let user: User? = User.fromJSON(dict: json)
                if let user = user {
                    self.user = user
                }
                completion()
            }
        }
        task.resume()
    }
    
    static func getUserConnected(id: UUID, completion: @escaping () -> Void) {
        self.getUserById(id: id) {
            DispatchQueue.main.async {
                self.userConnected = self.user
                completion()
            }
        }
    }
}
