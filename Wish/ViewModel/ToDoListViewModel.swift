
struct toDoListViewModel {
    let wish: Wish
    let cellNumber: Int
    
    var text: String {
        return wish.wish
    }
    
    var isChecked: Bool {
        return wish.isChecked ? false : true
    }
    
    init(wish: Wish, cellNumber: Int) {
        self.wish = wish
        self.cellNumber = cellNumber
    }
}
