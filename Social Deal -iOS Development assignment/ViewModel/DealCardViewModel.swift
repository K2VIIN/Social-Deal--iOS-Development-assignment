import Foundation
import Combine

class DealCardViewModel: ObservableObject {
    @Published var deals: [Deal] = []
    @Published var dealResult: Deal?
    private var cancellables = Set<AnyCancellable>()
    
    private let dealsURL = URL(string: "https://media.socialdeal.nl/demo/deals.json")!
    
    func loadDeals() {
        URLSession.shared.dataTaskPublisher(for: dealsURL)
            .map { $0.data }
            .handleEvents(receiveOutput: { data in
            })
            .decode(type: DealResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading deals: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] dealResponse in
                self?.deals = dealResponse.deals
                self?.dealResult = dealResponse.deals.first
            })
            .store(in: &cancellables)
    }
}
