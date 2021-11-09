import SwiftUI

struct SearchBarView: View {

    @Binding var searchText: String
    
    var body: some View {
        HStack {
            Image(systemName: IconAndImageNamesConstants.searchBarIconSystemName)
                .foregroundColor(
                    searchText.isEmpty
                    ? Color.theme.secondaryTextColor
                    : Color.theme.accentColor
                )
            TextField(TextConstants.searchBarTitlePlaceholder, text: $searchText)
                .foregroundColor(Color.theme.accentColor)
                .overlay(
                    Image(systemName: IconAndImageNamesConstants.xmarkCircleFillSystemName)
                        .foregroundColor(Color.theme.accentColor)
                    // this padding is put to get more place to tap
                        .padding()
                        .offset(x: 10)
                        .opacity(
                            searchText.isEmpty
                            ? 0.0
                            : 1.0
                        )
                        .onTapGesture {
                            searchText = ""
                        }
                    , alignment: .trailing
                )
        }
        .font(.headline)
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 25)
                .fill(Color.theme.backgroundColor)
                .shadow(
                    color: Color.theme.accentColor.opacity(0.25),
                    radius: 10,
                    x: 0, y: 0
                )
        )
        .padding()
    }
}

struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            SearchBarView(searchText: .constant(""))
                .previewLayout(.sizeThatFits)
            SearchBarView(searchText: .constant(""))
                .preferredColorScheme(.dark)
                .previewLayout(.sizeThatFits)
        }
    }
}
