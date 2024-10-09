import SwiftUI

/*  Because there are HTML tags in the description
 *  Can't parse tags like <strong> and some others
 *  I don't know if it's needed for this case
 */
extension String {
    func attributedText() -> Text {
        let htmlString = self
        let data = Data(htmlString.utf8)
        
        // Use NSAttributedString to convert HTML to attributed string
        if let attributedString = try? NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil) {
            return Text(attributedString.string) // Convert to Text
        }
        
        return Text(htmlString)
    }
}

struct DealDetail: View {
    @StateObject private var detailViewModel: DealDetailViewModel
    var dealId: String

    init(dealId: String) {
        self.dealId = dealId
        _detailViewModel = StateObject(wrappedValue: DealDetailViewModel())
    }

    var body: some View {
        VStack {
            if let deal = detailViewModel.deal {
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        if let imageUrlString = deal.image, let imageUrl = URL(string: imageUrlString) {
                            AsyncImage(url: imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 200)
                                    .clipped()
                            } placeholder: {
                                ProgressView()
                            }
                            .padding(.horizontal)
                        }

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
                            description.attributedText()
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
        .onAppear {
            detailViewModel.loadDealDetail(id: dealId)
        }
    }
}
