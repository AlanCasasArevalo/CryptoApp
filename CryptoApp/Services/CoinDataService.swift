import Foundation
import Combine

class CoinDataService {
    @Published var allCoins: [CoinModel] = []
    var coinSubscription: AnyCancellable?
    @Published var allCoinError: Error? = nil

    init() {
        getAllCoins()
    }

    private func getAllCoins() {
        guard let url = URL(string: "\(URLConstants.coingeckoBaseURL)?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h") else {
            return
        }

        coinSubscription = NetworkingManager.download(from: url)
                .decode(type: [CoinModel].self, decoder: JSONDecoder())
                /*
                This is other way to do if you want
                 .sink(receiveCompletion: NetworkingManager.handleCompletion) { [weak self] allCoinsFromBack in
                 self?.allCoins = allCoinsFromBack
                 self?.coinSubscription?.cancel()
                 }
                 */
                .sink(receiveCompletion: { [weak self] completion in
                    switch completion {
                    case .finished:
                        print("Finish")
                    case .failure(let error):
                        self?.allCoinError = error
                    }
                }, receiveValue: { [weak self] allCoinsFromBack in
                    self?.allCoins = allCoinsFromBack
                    self?.coinSubscription?.cancel()
                })
    }

}
