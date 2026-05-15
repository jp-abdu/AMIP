import SwiftUI

// ─────────────────────────────────────────────
// FormularioManager.swift
// Guarda o ID do formulário atual e compartilha entre todas as views.
// Adicionar ao projeto como um novo arquivo Swift.
// ─────────────────────────────────────────────

class FormularioManager: ObservableObject {
    static let shared = FormularioManager()
    @Published var formularioId: Int? = nil
    private init() {}
}

//teste
