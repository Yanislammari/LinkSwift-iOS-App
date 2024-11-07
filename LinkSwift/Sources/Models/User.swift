import Foundation

class User: CustomStringConvertible {
    let id: UUID
    let firstname: String
    let lastname: String
    let email: String
    let password: String
    let type: UserType
    let job: String?
    let searchJob: Bool
    let grade: UserGrade?
    let course: String?
    let profilePicture: Data
    let companyId: UUID?
    let schoolId: UUID?
    
    init(id: UUID, firstname: String, lastname: String, email: String, password: String, type: UserType, job: String?, searchJob: Bool, grade: UserGrade?, course: String?, profilePicture: Data, companyId: UUID?, schoolId: UUID?) {
        self.id = id
        self.firstname = firstname
        self.lastname = lastname
        self.email = email
        self.password = password
        self.type = type
        self.job = job
        self.searchJob = searchJob
        self.grade = grade
        self.course = course
        self.profilePicture = profilePicture
        self.companyId = companyId
        self.schoolId = schoolId
    }
    
    var description: String {
        return """
            User {
                id: \(self.id),
                firstname: \(self.firstname),
                lastname: \(self.lastname),
                email: \(self.email),
                password: \(self.password),
                type: \(self.type.rawValue),
                job: \(self.job ?? "N/A"),
                searchJob: \(self.searchJob),
                grade: \(self.grade?.rawValue ?? "N/A"),
                course: \(self.course ?? "N/A"),
                profilePicture: \(self.profilePicture.count) bytes,
                companyId: \(self.companyId?.uuidString ?? "N/A"),
                schoolId: \(self.schoolId?.uuidString ?? "N/A")
            }
        """
    }
    
    static func fromJSON(dict: [String: Any]) -> User? {
        guard
            let idString = dict["id"] as? String,
            let id = UUID(uuidString: idString),
            let firstname = dict["firstName"] as? String,
            let lastname = dict["lastName"] as? String,
            let email = dict["email"] as? String,
            let typeRaw = dict["type"] as? String,
            let type = UserType(rawValue: typeRaw),
            let searchJob = dict["searchJob"] as? Bool
        else {
            return nil
        }

        let job = dict["job"] as? String
        let gradeRaw = dict["grade"] as? String
        let grade = gradeRaw != nil ? UserGrade(rawValue: gradeRaw!) : nil
        let course = dict["course"] as? String

        var profilePictureData: Data = Data()
        if let profilePictureBase64 = dict["profilePicture"] as? String,
           let decodedData = Data(base64Encoded: profilePictureBase64) {
            profilePictureData = decodedData
        }

        let companyIdString = dict["companyId"] as? String
        let companyId = companyIdString != nil ? UUID(uuidString: companyIdString!) : nil

        let schoolIdString = dict["schoolId"] as? String
        let schoolId = schoolIdString != nil ? UUID(uuidString: schoolIdString!) : nil

        return User(id: id, firstname: firstname, lastname: lastname, email: email, password: "", type: type, job: job, searchJob: searchJob, grade: grade, course: course, profilePicture: profilePictureData, companyId: companyId, schoolId: schoolId)
    }
}
