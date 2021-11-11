import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []
    @Published var allCoinError: Error? = nil
    @Published var searchText: String = ""

    private let dataServices = CoinDataService()
    private var cancellable = Set<AnyCancellable>()

    init() {
       addSubscribers()
    }

    func addSubscribers(){
        /*
         This function is not necesary because last one do the same combine search bar and download
        dataServices.$allCoins
        .sink { [weak self] allCoinsReceived in
            self?.allCoins = allCoinsReceived
        }
        .store(in: &cancellable)

        dataServices.$allCoinError
        .sink { [weak self] allCoinErrorReceived in
            self?.allCoinError = allCoinErrorReceived
        }
        .store(in: &cancellable)
         */

        $searchText
            .combineLatest(dataServices.$allCoins)
            .map(filterCoins)
            .sink { [weak self] allCoinsReceived in
                self?.allCoins = allCoinsReceived
            }
            .store(in: &cancellable)

    }
    
    private func filterCoins(text: String, coins: [CoinModel]) -> [CoinModel] {
        guard !text.isEmpty else {
            return coins
        }
        
        let textLowercased = text.lowercased()
        let filteredCoins = coins.filter { coin in
            coin.symbol?.lowercased().contains(textLowercased) ?? false ||
            coin.name?.lowercased().contains(textLowercased) ?? false ||
            coin.id?.lowercased().contains(textLowercased) ?? false
        }
        
        return filteredCoins
    }

}
