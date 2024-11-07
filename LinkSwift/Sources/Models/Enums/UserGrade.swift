enum UserGrade: String {
    case noBac = "SANS BAC"
    case bac = "BAC"
    case bacPlus1 = "BAC+1"
    case bacPlus2 = "BAC+2"
    case bacPlus3 = "BAC+3"
    case bacPlus5 = "BAC+5"
    case bacPlus7 = "BAC+7"
    case bacPlus8 = "BAC+8"
    case bacPlus9 = "BAC+9"
    case bacPlus12 = "BAC+12"
    
    func getLabel() -> String {
        return self.rawValue
    }
}
