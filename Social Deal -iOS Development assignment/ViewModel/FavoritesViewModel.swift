import Foundation
import Combine

class FavoritesViewModel: ObservableObject {
    @Published var favoriteDeals: [Deal] = []

    func toggleFavorite(deal: Deal) {
        if let index = favoriteDeals.firstIndex(of: deal) {
            favoriteDeals.remove(at: index)
        } else {
            favoriteDeals.append(deal)
        }
    }

    func isFavorite(deal: Deal) -> Bool {
        favoriteDeals.contains(deal)
    }
}
