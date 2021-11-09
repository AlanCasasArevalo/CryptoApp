import SwiftUI

struct CircularButtonView: View {
    
    let iconName: String
    
    var body: some View {
        Image(systemName: iconName)
            .foregroundColor(Color.theme.accentColor)
            .frame(width: 50, height: 50)
            .background(
                Circle()
                    .foregroundColor(Color.theme.backgroundColor)
            )
            .shadow(
                color: Color.theme.accentColor.opacity(0.30),
                radius: 10,
                x: 0,
                y: 0
            )
            .padding()
    }
}

struct CircularButtonView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CircularButtonView(iconName: "info")
                .previewLayout(.sizeThatFits)
            CircularButtonView(iconName: "plus")
                .previewLayout(.sizeThatFits)
                .colorScheme(.dark)
        }
    }
}
