import Foundation

class Company : CustomStringConvertible {
    let id: UUID
    let name: String
    let companyDescription: String
    let expertiseArea: String
    let website: String
    let picture: Data
    
    init(id: UUID, name: String, description: String, expertiseArea: String, website: String, picture: Data) {
        self.id = id
        self.name = name
        self.companyDescription = description
        self.expertiseArea = expertiseArea
        self.website = website
        self.picture = picture
    }
    
    var description: String {
        return """
            Company {
                id: \(self.id.uuidString),
                name: \(self.name),
                description: \(self.companyDescription),
                expertiseArea: \(self.expertiseArea),
                website: \(self.website),
                picture: \(self.picture.count) bytes
            }
        """
    }
    
    static func fromJSON(dict: [String : Any]) -> Company? {
        guard
            let id = dict["id"] as? UUID,
            let name = dict["name"] as? String,
            let description = dict["description"] as? String,
            let expertiseArea = dict["expertiseArea"] as? String,
            let website = dict["website"] as? String,
            let picture = dict["picture"] as? Data
        else {
            return nil
        }
        return Company(id: id, name: name, description: description, expertiseArea: expertiseArea, website: website, picture: picture)
    }
}
