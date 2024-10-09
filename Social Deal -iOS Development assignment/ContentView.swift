import SwiftUI

struct ContentView: View {
    @ObservedObject var cardViewModel = DealCardViewModel()

    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(cardViewModel.deals, id: \.unique) { deal in
                        DealCard(cardViewModel: cardViewModel, deal: deal)
                            .onAppear {
                                if deal == cardViewModel.deals.last {
                                    cardViewModel.loadDeals()
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
    }
}
