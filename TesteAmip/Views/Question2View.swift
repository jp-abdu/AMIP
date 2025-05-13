//
//  Question2View.swift
//  TesteAmip
//
//  Created by FELLIPE MARTINS VALLADARES on 13/05/25.
//

import SwiftUI

struct Question2View: View {
    var body: some View {
        NavigationLink(destination: FormularioEnviadoView()) {
            Text("Concluir")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.green)
                .foregroundColor(.white)
                .cornerRadius(10)
        }
    }
}
