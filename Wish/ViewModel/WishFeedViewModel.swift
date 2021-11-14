import UIKit

enum RowNumber: CaseIterable {
    
    case first
    case second
    case third
    case forth
    case fifth
}

struct WishFeedViewModel {
    let wish: Wish
    let rowHeight: CGFloat
    let rowNumber: RowNumber
    
    var wishText: String {
        return wish.wish
    }
    
    var wishTextAlignment: NSTextAlignment {
        switch rowNumber {
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
        switch rowNumber {
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
    
    init(wish: Wish, rowHeight: CGFloat, rowNumber: RowNumber) {
        self.wish = wish
        self.rowHeight = rowHeight
        self.rowNumber = rowNumber
    }
}
