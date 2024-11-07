import Foundation

class AuthService {
    static var message: String? = nil
    static var token: String? = nil
    
    static func login(email: String, password: String, completion: @escaping () -> Void) {
        let body: [String : String] = [
            "email": email,
            "password": password
        ]
        guard let jsonBody: Data = try? JSONSerialization.data(withJSONObject: body) else {
            return
        }
        let url: URL = URL(string: "\(Api.baseUrl)/auth/login")!
        var request: URLRequest = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonBody
        
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
                if let message = json["message"] as? String {
                    self.message = message
                }
                if let token = json["token"] as? String {
                    self.token = token
                }
                completion()
            }
        }
        task.resume()
    }
}
