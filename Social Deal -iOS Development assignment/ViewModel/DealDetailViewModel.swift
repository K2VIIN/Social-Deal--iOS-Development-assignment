import Foundation
import Combine

class DealDetailViewModel: ObservableObject {
    @Published var deal: Deal?
    private var cancellables = Set<AnyCancellable>()

    func loadDealDetail(id: String) {
        let detailURL = URL(string: "https://media.socialdeal.nl/demo/details.json?id=\(id)")!
        
        cancellables.removeAll()

        URLSession.shared.dataTaskPublisher(for: detailURL)
            .map { $0.data }
            .decode(type: Deal.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink(receiveCompletion: { completion in
                switch completion {
                case .failure(let error):
                    print("Error loading deal details: \(error)")
                case .finished:
                    break
                }
            }, receiveValue: { [weak self] deal in
                self?.deal = deal
            })
            .store(in: &cancellables)
    }
}
