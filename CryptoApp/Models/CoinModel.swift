import Foundation

// Coin gecko API Info
/*
 vs_currency:
 usd, eur, jpy
 
 order:
 market_cap_desc, gecko_desc, gecko_asc, market_cap_asc, market_cap_desc, volume_asc, volume_desc, id_asc, id_desc
 
 price_change_percentage:
 1h, 24h, 7d, 14d, 30d, 200d, 1y
 
 URL : https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&order=market_cap_desc&per_page=250&page=1&sparkline=true&price_change_percentage=24h
 
 JSON RESPONSE:
 [
     {
         "id": "bitcoin",
         "symbol": "btc",
         "name": "Bitcoin",
         "image": "https://assets.coingecko.com/coins/images/1/large/bitcoin.png?1547033579",
         "current_price": 68211,
         "market_cap": 1289529508738,
         "market_cap_rank": 1,
         "fully_diluted_valuation": 1435230637496,
         "total_volume": 39518893618,
         "high_24h": 68642,
         "low_24h": 65500,
         "price_change_24h": 2182.55,
         "price_change_percentage_24h": 3.30547,
         "market_cap_change_24h": 39717463988,
         "market_cap_change_percentage_24h": 3.17787,
         "circulating_supply": 18868131.0,
         "total_supply": 21000000.0,
         "max_supply": 21000000.0,
         "ath": 68642,
         "ath_change_percentage": -0.41882,
         "ath_date": "2021-11-09T04:09:45.771Z",
         "atl": 67.81,
         "atl_change_percentage": 100703.85373,
         "atl_date": "2013-07-06T00:00:00.000Z",
         "roi": {
 "times": 93.29370912209797,
 "currency": "btc",
 "percentage": 9329.370912209797
},
         "last_updated": "2021-11-09T10:35:37.426Z",
         "sparkline_in_7d": {
           "price": [
             61641.40385445087,
             61822.54395425892,
             68078.55816165461
           ]
         },
         "price_change_percentage_24h_in_currency": 3.305465605123893
       }
 ]
 
 */

import Foundation

struct CoinModel: Codable, Identifiable {
    let id, symbol, name: String?
    let image: String?
    let currentPrice, marketCap, marketCapRank, fullyDilutedValuation: Double?
    let totalVolume, high24H, low24H: Double?
    let priceChange24H, priceChangePercentage24H: Double?
    let marketCapChange24H: Double?
    let marketCapChangePercentage24H: Double?
    let circulatingSupply, totalSupply, maxSupply, ath: Double?
    let athChangePercentage: Double?
    let athDate: String?
    let atl, atlChangePercentage: Double?
    let atlDate: String?
    let roi: Roi?
    let lastUpdated: String?
    let sparklineIn7D: SparklineIn7D?
    let priceChangePercentage24HInCurrency: Double?
    let currentHoldings: Double?

    enum CodingKeys: String, CodingKey {
        case id, symbol, name, image
        case currentPrice = "current_price"
        case marketCap = "market_cap"
        case marketCapRank = "market_cap_rank"
        case fullyDilutedValuation = "fully_diluted_valuation"
        case totalVolume = "total_volume"
        case high24H = "high_24h"
        case low24H = "low_24h"
        case priceChange24H = "price_change_24h"
        case priceChangePercentage24H = "price_change_percentage_24h"
        case marketCapChange24H = "market_cap_change_24h"
        case marketCapChangePercentage24H = "market_cap_change_percentage_24h"
        case circulatingSupply = "circulating_supply"
        case totalSupply = "total_supply"
        case maxSupply = "max_supply"
        case ath
        case athChangePercentage = "ath_change_percentage"
        case athDate = "ath_date"
        case atl
        case atlChangePercentage = "atl_change_percentage"
        case atlDate = "atl_date"
        case roi
        case lastUpdated = "last_updated"
        case sparklineIn7D = "sparkline_in_7d"
        case priceChangePercentage24HInCurrency = "price_change_percentage_24h_in_currency"
    }
    
    func updateHoldings(ammount: Double) -> CoinModel {
        return CoinModel(id: id, symbol: symbol, name: name, image: image, currentPrice: currentPrice, marketCap: marketCap, marketCapRank: marketCapRank, fullyDilutedValuation: fullyDilutedValuation, totalVolume: totalVolume, high24H: high24H, low24H: low24H, priceChange24H: priceChange24H, priceChangePercentage24H: priceChangePercentage24H, marketCapChange24H: marketCapChange24H, marketCapChangePercentage24H: marketCapChangePercentage24H, circulatingSupply: circulatingSupply, totalSupply: totalSupply, maxSupply: maxSupply, ath: ath, athChangePercentage: athChangePercentage, athDate: athDate, atl: atl, atlChangePercentage: atlChangePercentage, atlDate: atlDate, roi: roi, lastUpdated: lastUpdated, sparklineIn7D: sparklineIn7D, priceChangePercentage24HInCurrency: priceChangePercentage24HInCurrency, currentHoldings: ammount)
    }
    
    var currentHoldingsValue: Double {
        return (currentPrice ?? 0) * (currentHoldings ?? 0)
    }
    
    var rank: Int {
        return Int(marketCapRank ?? 0)
    }
    
}

struct Roi: Codable {
    let times: Double?
    let currency: String?
    let percentage: Double?
}

struct SparklineIn7D: Codable {
    let price: [Double]?
}
