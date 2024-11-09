import Foundation

class School : CustomStringConvertible {
    let id: UUID
    let name: String
    let schoolDescription: String
    let website: String
    let picture: Data
    
    init(id: UUID, name: String, description: String, website: String, picture: Data) {
        self.id = id
        self.name = name
        self.schoolDescription = description
        self.website = website
        self.picture = picture
    }
    
    var description: String {
        return """
            School {
                id: \(self.id),
                name: \(self.name),
                description: \(self.schoolDescription),
                website: \(self.website),
                picture: \(self.picture.count) bytes
            }
        """
    }
    
    static func fromJSON(dict: [String : Any]) -> School? {
        guard
            let id = dict["id"] as? UUID,
            let name = dict["name"] as? String,
            let description = dict["description"] as? String,
            let website = dict["website"] as? String,
            let picture = dict["picture"] as? Data
        else {
            return nil
        }
        return School(id: id, name: name, description: description, website: website, picture: picture)
    }
}
