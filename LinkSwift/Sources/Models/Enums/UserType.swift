enum UserType: String {
    case user = "USER"
    case admin = "ADMIN"
    
    func getLabel() -> String {
        return self.rawValue
    }
}
