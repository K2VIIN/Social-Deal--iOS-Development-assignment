import SwiftUI

struct FavoritesView: View {
    @ObservedObject var favoritesViewModel: FavoritesViewModel

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(favoritesViewModel.favoriteDeals, id: \.unique) { deal in
                        DealCard(cardViewModel: DealCardViewModel(), favoritesViewModel: favoritesViewModel, deal: deal)
                            .contextMenu {
                                Button(action: {
                                    favoritesViewModel.toggleFavorite(deal: deal)
                                }) {
                                    Text("Remove from Favorites")
                                }
                            }
                    }
                }
                .padding()
            }
            .navigationTitle("Favorites")
        }
    }
}
