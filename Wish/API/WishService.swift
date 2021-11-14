import UIKit
import Firebase

struct WishService {
    
    static func uploadWishes(wishes: [Wish], completion: @escaping ((Error?) -> Void)) {
        
        wishes.forEach { wish in
            if wish.id == nil {
                COLLECTION_WISHES.addDocument(data: ["wish": wish.wish,
                                                     "isChecked": wish.isChecked,
                                                     "timestamp": Timestamp(date: Date())], completion: completion)
            } else {
                COLLECTION_WISHES.document(wish.id ?? "").updateData(["wish": wish.wish,
                                                                      "isChecked": wish.isChecked,
                                                                      "timestamp": Timestamp(date: Date())], completion: completion)
            }
        }
    }
    
    static func fetchWishes(completion: @escaping (([Wish]) -> Void)) {
        
        COLLECTION_WISHES.order(by: "timestamp", descending: false).getDocuments { snapshot, error in
            
            if let error = error {
                print("fali to fetch: \(error.localizedDescription)")
                return
            }
            
            guard let documents = snapshot?.documents else { return }
            
            let wishes = documents.map { Wish(id: $0.documentID, dictionary: $0.data()) }
            completion(wishes)
        }
    }
}
