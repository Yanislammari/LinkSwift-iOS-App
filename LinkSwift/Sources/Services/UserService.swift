import Foundation

class UserService {
    static var userId: UUID? = nil
        
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
}
