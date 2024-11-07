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
    
    static func register(firstname: String, lastname: String, email: String, password: String, profilePicture: Data, completion: @escaping () -> Void) {
        var body: Data = Data()
        let url: URL = URL(string: "\(Api.baseUrl)/auth/register")!
        var request: URLRequest = URLRequest(url: url)
        let boundary: String = UUID().uuidString
        request.httpMethod = "POST"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"firstName\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(firstname)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"lastName\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(lastname)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"email\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(email)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"password\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(password)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"profilePicture\"; filename=\"profile.jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(profilePicture)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        request.httpBody = body
        
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
