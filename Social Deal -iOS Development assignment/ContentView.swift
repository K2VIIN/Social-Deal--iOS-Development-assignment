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
                            NavigationLink(destination: DealDetail(dealId: deal.unique)) {
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
                    // Load initial batch of deals if not already loaded
                    if cardViewModel.deals.isEmpty {
                        cardViewModel.loadDeals()
                    }
                }
            }
            .tabItem {
                Label("Deals", systemImage: "list.bullet")
            }

            FavoritesView(favoritesViewModel: favoritesViewModel)
                .tabItem {
                    Label("Favorites", systemImage: "star")
                }
        }
    }
}
