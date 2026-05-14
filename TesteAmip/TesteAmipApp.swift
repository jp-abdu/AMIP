import SwiftUI

@main
struct MeuApp: App {
    @StateObject private var formularioState = FormularioState()

    var body: some Scene {
        WindowGroup {
            SplashView()
                .environmentObject(formularioState)
        }
    }
}

