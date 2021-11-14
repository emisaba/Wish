import Firebase

struct Wish {
    let wish: String
    var isChecked: Bool
    let timestamp: Timestamp
    let id: String?
    
    init(id: String?, dictionary: [String: Any]) {
        self.id = id
        self.wish = dictionary["wish"] as? String ?? ""
        self.isChecked = dictionary["isChecked"] as? Bool ?? true
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }
}
