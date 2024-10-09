import SwiftUI

struct ContentView: View {
    @ObservedObject var cardViewModel = DealCardViewModel()
    @StateObject var favoritesViewModel = FavoritesViewModel()

    var body: some View {
        TabView {
            NavigationView {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(cardViewModel.deals, id: \.unique) { deal in
                            NavigationLink(destination: DealDetail(detailViewModel: DealDetailViewModel(), dealId: deal.unique)) {
                                DealCard(cardViewModel: DealCardViewModel(), favoritesViewModel: favoritesViewModel, deal: deal)
                                    .contextMenu {
                                        Button(action: {
                                            favoritesViewModel.toggleFavorite(deal: deal)
                                        }) {
                                            Text(favoritesViewModel.isFavorite(deal: deal) ? "Remove from Favorites" : "Add to Favorites")
                                        }
                                    }
                                    .onAppear {
                                        if deal == cardViewModel.deals.last {
                                            cardViewModel.loadDeals()
                                        }
                                    }
                            }
                        }
                    }
                    .padding()
                }
                .navigationTitle("Deals")
                .onAppear {
                    cardViewModel.loadDeals()
                }
            }
            .tabItem {
                Label("Deals", systemImage: "list.bullet")
            }

            FavoritesView(favoritesViewModel: favoritesViewModel) // Add your favorites view
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}
