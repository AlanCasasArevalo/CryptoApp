import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    @Published var allCoinError: Error? = nil

    init () {
        getAllCoins()
    }

    private func getAllCoins () {
        guard let url = URL(string: "\(URLConstants.coingeckoBaseURL)?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else { return }

        coinSubscription = URLSession.shared.dataTaskPublisher(for: url)
        .subscribe(on: DispatchQueue.global(qos: .default))
        .tryMap { [weak self] (output) -> Data in
            guard let response = output.response as? HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
                self?.allCoinError = URLError(.badServerResponse)
                throw URLError(.badServerResponse)
            }
            return output.data
        }
        .receive(on: DispatchQueue.main)
        .decode(type: [CoinModel].self, decoder: JSONDecoder())
        .sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("Finish")
            case .failure(let error):
                print("Finish with Error: \(error.localizedDescription)")
            }
        }, receiveValue: { [weak self] allCoinsFromBack in
            self?.allCoins = allCoinsFromBack
            self?.coinSubscription?.cancel()
        })
    }

}
