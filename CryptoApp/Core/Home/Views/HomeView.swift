import SwiftUI

struct HomeView: View {
    
    @State private var showPortfolio = false
    
    var body: some View {
        ZStack {
            Color.theme.backgroundColor
                .ignoresSafeArea()
            
            VStack {
                homeHeaderView
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
}
