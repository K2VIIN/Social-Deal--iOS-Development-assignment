import SwiftUI

struct DealCard: View {
    @ObservedObject var cardViewModel: DealCardViewModel
    @State private var isFavorite = false
    
    var deal: Deal

    var body: some View {
        VStack {
            // Deal Image
            if let imageUrl = URL(string: "https://images.socialdeal.nl" + deal.image) {
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
            
            // Deal Information
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
                    
                    // Favorite Button (Heart Icon)
                    Button(action: {
                        isFavorite.toggle()
                    }) {
                        Image(systemName: isFavorite ? "heart.fill" : "heart")
                            .foregroundColor(isFavorite ? .red : .gray)
                            .font(.title3)
                    }
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
        }
        .cornerRadius(10)
        .shadow(radius: 5)
        .padding()
    }
}
