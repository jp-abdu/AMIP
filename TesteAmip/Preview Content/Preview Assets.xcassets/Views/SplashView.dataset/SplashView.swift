import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        ZStack {
            Color(red: 0.85, green: 1.0, blue: 1.0)
                .ignoresSafeArea() // ocupa a tela toda

            VStack {
                Image("amip_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isActive = true
                }
            }
        }
        .fullScreenCover(isPresented: $isActive) {
            LoginView()
        }
    }
}
