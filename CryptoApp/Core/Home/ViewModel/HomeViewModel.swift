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
    }

}
