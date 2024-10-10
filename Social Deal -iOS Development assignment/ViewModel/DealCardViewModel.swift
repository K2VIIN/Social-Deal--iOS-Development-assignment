import Foundation
import Combine

class DealCardViewModel: ObservableObject {
    @Published var deals: [Deal] = []
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 0
    private let pageSize = 10
    private var isLoading = false
    
    private let dealsURL = URL(string: "https://media.socialdeal.nl/demo/deals.json")!
    
    func loadDeals() {
        guard !isLoading else { return }
        isLoading = true
        
        URLSession.shared.dataTaskPublisher(for: dealsURL)
            .map { $0.data }
            .decode(type: DealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                self.isLoading = false
                switch completion {
                case .failure(let error):
                    print("Error loading deals: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] dealResponse in
                // Add the new deals based on pagination
                if let currentPageDeals = self?.getPaginatedDeals(from: dealResponse.deals) {
                    self?.deals.append(contentsOf: currentPageDeals)
                    self?.currentPage += 1
                }
            })
            .store(in: &cancellables)
    }

    private func getPaginatedDeals(from allDeals: [Deal]) -> ArraySlice<Deal> {
        let startIndex = currentPage * pageSize
        let endIndex = min(startIndex + pageSize, allDeals.count)
        return allDeals[startIndex..<endIndex]
    }
}
