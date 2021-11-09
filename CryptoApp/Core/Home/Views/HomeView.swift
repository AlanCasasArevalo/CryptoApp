import SwiftUI

struct HomeView: View {
    
    @EnvironmentObject private var viewModel: HomeViewModel
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
                
                columnTitlesView
                
                if !showPortfolio {
                    allCoinListView
                        .transition(.move(edge: .leading))
                } else {
                    portfolioCoinListView
                        .transition(.move(edge: .trailing))

                }
                
                Spacer(minLength: 0)
            }
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            NavigationView {
                HomeView()
                    .preferredColorScheme(.light)
                    .navigationBarHidden(true)
            }
            .environmentObject(dev.homeViewModel)
        }
    }
}

extension HomeView {
    private var homeHeaderView: some View {
        HStack {
            CircularButtonView(iconName: showPortfolio ? IconAndImageNamesConstants.plusSystemName : IconAndImageNamesConstants.infoSystemName)
                .background(
                    CircularButtonAnimationView(animate: $showPortfolio)
                )
                .animation(.none)
            Spacer()
            Text(showPortfolio ? TextConstants.portfolioHeaderTitle : TextConstants.livePricesHeaderTitle)
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundColor(Color.theme.accentColor)
                .animation(.none)

            Spacer()
            CircularButtonView(iconName: IconAndImageNamesConstants.rightChevronSystemName)
                .rotationEffect(Angle(degrees: showPortfolio ? 180 : 0))
                .onTapGesture {
                    withAnimation(.spring()) {
                        showPortfolio.toggle()
                    }
                }
        }
        .padding(.horizontal)
    }
    
    private var allCoinListView: some View {
        List {
            ForEach(viewModel.allCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: false)
                    .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var portfolioCoinListView: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin, showHoldingsColumn: true)
                    .listRowInsets(.init(top: 0, leading: 8, bottom: 0, trailing: 8))
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var columnTitlesView: some View {
        HStack {
            Text(TextConstants.columnCoinHeaderTitle)
            Spacer()
            if showPortfolio {
                Text(TextConstants.columnHoldingsHeaderTitle)
            }
            Text(TextConstants.columnPriceHeaderTitle)
                .frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
        }
        .font(.caption)
        .foregroundColor(Color.theme.secondaryTextColor)
        .padding(.horizontal)
    }

}
