import SwiftUI

struct DealDetail: View {
    @ObservedObject var detailViewModel: DealDetailViewModel
    
    var dealId: String
    
    var body: some View {
        VStack {
            if let deal = detailViewModel.deal {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        Text(deal.title)
                            .font(.title)
                            .padding(.top)
                        
                        Text(deal.company)
                            .font(.headline)
                            .foregroundColor(.gray)
                        
                        Text(deal.city)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        
                        if let description = deal.description {
                            Text(description)
                                .font(.body)
                                .padding(.top)
                        }
                        
                        HStack {
                            Text("Verkocht: \(deal.soldLabel)")
                                .font(.footnote)
                                .foregroundColor(.blue)
                            Spacer()
                        }
                        
                        HStack {
                            Text(String(format: "€%.2f", (deal.prices.fromPrice?.amount ?? 0) / 100))
                                .strikethrough()
                                .foregroundColor(.gray)
                            
                            Text(String(format: "€%.2f", (deal.prices.price?.amount ?? 0) / 100))
                                .font(.title3)
                                .foregroundColor(.green)
                                .bold()
                        }
                    }
                    .padding()
                }
            } else {
                ProgressView()
                    .onAppear {
                        detailViewModel.loadDealDetail(id: dealId)
                    }
            }
        }
        .navigationTitle("Deal Details")
    }
}

