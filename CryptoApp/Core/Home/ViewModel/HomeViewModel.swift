import Combine
import Foundation

class HomeViewModel: ObservableObject {
    
    @Published var allCoins: [CoinModel] = []
    @Published var portfolioCoins: [CoinModel] = []

    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            self?.allCoins.append(DevPreviewProvider.instance.coin)
            self?.portfolioCoins.append(DevPreviewProvider.instance.coin)
        }
    }
}
