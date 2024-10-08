import SwiftUI

struct DealCard: View {
    @ObservedObject var cardViewModel: DealCardViewModel
    
    var body: some View {
        VStack {
            if let deal = cardViewModel.dealResult,
               let imageUrl = URL(string: "https://images.socialdeal.nl" + deal.image) {
                AsyncImage(url: imageUrl) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(height: 200)
                        .clipped()
                } placeholder: {
                    ProgressView()
                        .frame(height: 200)
                }
            } else {
                Color.gray.frame(height: 200)
            }
            
            if let deal = cardViewModel.dealResult {
                VStack(alignment: .leading, spacing: 8) {
                    Text(deal.title)
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text(deal.company)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text(deal.city)
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text(deal.soldLabel)
                            .font(.footnote)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    
                    HStack {
                        Text(String(format: "€%.2f", (deal.prices.fromPrice?.amount ?? 0) / 100))
                            .font(.subheadline)
                            .strikethrough()
                            .foregroundColor(.gray)
                        
                        Text(String(format: "€%.2f", (deal.prices.price?.amount) ?? 0 / 100))
                            .font(.title3)
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                .padding()
                .background(Color.white)
            } else {
                // Placeholder view if the deal data isn't available
                VStack(alignment: .leading, spacing: 8) {
                    Text("Deal title")
                        .font(.headline)
                        .foregroundColor(.black)
                    
                    Text("Company name")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    Text("City")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    
                    HStack {
                        Text("Verkocht: 0")
                            .font(.footnote)
                            .foregroundColor(.blue)
                        Spacer()
                    }
                    
                    HStack {
                        Text("€0.00")
                            .font(.subheadline)
                            .strikethrough()
                            .foregroundColor(.gray)
                        
                        Text("€0.00")
                            .font(.title3)
                            .foregroundColor(.green)
                            .bold()
                    }
                }
                .padding()
                .background(Color.white)
            }
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
        .onAppear {
            cardViewModel.loadDeals()
        }
    }
}
