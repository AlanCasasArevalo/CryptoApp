import SwiftUI

struct CoinRowView: View {
    let coin: CoinModel
    let showHoldingsColumn: Bool

    var body: some View {
        HStack {

            leftColumn

            Spacer(minLength: 0)

            if showHoldingsColumn {
                centerColumn
            }

            rightColumn
        }
        .font(.subheadline)
    }
}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .previewLayout(.sizeThatFits)
            .padding()
            CoinRowView(coin: dev.coin, showHoldingsColumn: false)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
            CoinRowView(coin: dev.coin, showHoldingsColumn: false)
                .previewLayout(.sizeThatFits)
            .padding()
            CoinRowView(coin: dev.coin, showHoldingsColumn: true)
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
                .padding()
        }
    }
}

extension CoinRowView {
    private var leftColumn: some View {
        HStack (spacing: 0) {
            Text("\(coin.rank)")
                .font(.caption)
                .foregroundColor(Color.theme.secondaryTextColor)
                .frame(minWidth: 30)

            UrlImageView(urlString: coin.image)
                .frame(width: 30, height: 30)

            Text(coin.symbol?.uppercased() ?? "")
                .font(.headline)
                .padding(.leading, 8)
                .foregroundColor(Color.theme.accentColor)
        }
    }

    private var centerColumn: some View {
        VStack (alignment: .trailing) {
            Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
                .bold()

            Text((coin.currentHoldings ?? 0).asNumberString())
        }
        .foregroundColor(Color.theme.accentColor)
    }

    private var rightColumn: some View {
        VStack (alignment: .trailing) {
            Text(coin.currentPrice?.asCurrencyWith6Decimals() ?? "")
                .bold()
                .foregroundColor(Color.theme.accentColor)

            Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
                .foregroundColor(
                    coin.priceChangePercentage24H ?? 0 >= 0
                    ? Color.theme.greenColor
                    : Color.theme.redColor
                )
        }
        .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
    }

}

