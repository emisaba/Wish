import UIKit

enum CellRow: CaseIterable {
    
    case first
    case second
    case third
    case forth
    case fifth
}

struct WishFeedViewModel {
    let wish: Wish
    let rowHeight: CGFloat
    let cellRow: CellRow
    
    var wishText: String {
        return wish.wish
    }
    
    var wishTextAlignment: NSTextAlignment {
        switch cellRow {
        case .first:
            return .left
        case .second:
            return .right
        case .third:
            return .center
        case .forth:
            return .right
        case .fifth:
            return .left
        }
    }
    
    var animationDelaySec: Double {
        switch cellRow {
        case .first:
            return 12
        case .second:
            return 24
        case .third:
            return 0
        case .forth:
            return 6
        case .fifth:
            return 18
        }
    }
    
    init(wish: Wish, rowHeight: CGFloat, cellRow: CellRow) {
        self.wish = wish
        self.rowHeight = rowHeight
        self.cellRow = cellRow
    }
}
