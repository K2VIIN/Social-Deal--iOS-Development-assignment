import SwiftUI

struct ContentView: View {
    @StateObject private var cardViewModel = DealCardViewModel()

    var body: some View {
        VStack {
            DealCard(cardViewModel: cardViewModel)
        }
        .padding()
        .onAppear {
            cardViewModel.loadDeals()
        }
    }
}

#Preview {
    ContentView()
}
