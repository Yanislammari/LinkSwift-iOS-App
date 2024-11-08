import Foundation

class Post: CustomStringConvertible {
    let id: UUID
    let content: String
    let categories: [String]?
    let media: Data?
    let userId: UUID

    init(id: UUID, content: String, categories: [String]?, media: Data?, userId: UUID) {
        self.id = id
        self.content = content
        self.categories = categories
        self.media = media
        self.userId = userId
    }

    var description: String {
        return """
            Post {
                id: \(self.id.uuidString),
                content: \(self.content),
                categories: \(self.categories?.joined(separator: ", ") ?? "N/A"),
                media: \(self.media?.count ?? 0) bytes,
                userId: \(self.userId.uuidString)
            }
        """
    }

    static func fromJSON(dict: [String: Any]) -> Post? {
        guard
            let idString = dict["id"] as? String,
            let id = UUID(uuidString: idString),
            let content = dict["content"] as? String,
            let userIdString = dict["userId"] as? String,
            let userId = UUID(uuidString: userIdString)
        else {
            return nil
        }

        let categories = dict["categories"] as? [String]
        
        var mediaData: Data? = nil
        if let mediaBase64 = dict["media"] as? String,
           let decodedData = Data(base64Encoded: mediaBase64) {
            mediaData = decodedData
        }

        return Post(id: id, content: content, categories: categories, media: mediaData, userId: userId)
    }
}
