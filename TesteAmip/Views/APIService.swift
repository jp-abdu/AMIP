import Foundation

// ─────────────────────────────────────────────
// APIService.swift
// Serviço centralizado para comunicação com o backend AMIP.
// Substitui todas as funções postResposta() espalhadas nas views.
// ─────────────────────────────────────────────

class APIService {
    static let shared = APIService()
    private let baseURL = "https://amip-backend-wlr2.onrender.com"

    private init() {}

    // MARK: - Cria formulário (chamar ao iniciar o questionário)
    func criarFormulario(completion: @escaping (Int?) -> Void) {
        guard let url = URL(string: "\(baseURL)/api/formularios/") else {
            completion(nil); return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, _, error in
            guard let data = data, error == nil,
                  let json = try? JSONSerialization.jsonObject(with: data) as? [String: Any],
                  let id = json["id"] as? Int else {
                completion(nil); return
            }
            completion(id)
        }.resume()
    }

    // MARK: - Finaliza formulário (chamar ao chegar na FormularioEnviadoView)
    func finalizarFormulario(id: Int) {
        guard let url = URL(string: "\(baseURL)/api/formularios/\(id)/finalizar") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PATCH"
        URLSession.shared.dataTask(with: request).resume()
    }

    // MARK: - Seção 1
    func enviarDomicilio(id: Int, rua: String, numero: String, complemento: String, especie: String, tipo: String) {
        let body: [String: Any] = [
            "rua": rua, "numero": numero,
            "complemento": complemento,
            "especie": especie, "tipo": tipo
        ]
        post(path: "/api/formularios/\(id)/domicilio", body: body)
    }

    // MARK: - Seção 2
    func enviarMoradores(id: Int, numeroMoradores: Int, nomeCompleto: String,
                         dataNascimento: String, datasNascimentoMoradores: [String],
                         sexo: String, parentesco: String, situacaoDomicilio: String) {
        // Converte o array de datas para string JSON
        let datasJSON: String
        if let data = try? JSONSerialization.data(withJSONObject: datasNascimentoMoradores),
           let str = String(data: data, encoding: .utf8) {
            datasJSON = str
        } else {
            datasJSON = "[]"
        }

        let body: [String: Any] = [
            "numero_moradores": numeroMoradores,
            "nome_completo": nomeCompleto,
            "data_nascimento": dataNascimento,
            "datas_nascimento_moradores": datasJSON,
            "sexo": sexo,
            "parentesco": parentesco,
            "situacao_domicilio": situacaoDomicilio
        ]
        post(path: "/api/formularios/\(id)/moradores", body: body)
    }

    // MARK: - Seção 3
    func enviarCaracteristicas(id: Int, comodos: String, dormitorios: String, banheirosCom: String, banheirosSem: String, internet: String, maquinaLavar: String) {
        let body: [String: Any] = [
            "quantidade_comodos": comodos,
            "quantidade_dormitorios": dormitorios,
            "banheiros_com_chuveiro": banheirosCom,
            "banheiros_sem_chuveiro": banheirosSem,
            "acesso_internet": internet,
            "possui_maquina_lavar": maquinaLavar
        ]
        post(path: "/api/formularios/\(id)/caracteristicas", body: body)
    }

    // MARK: - Seção 4
    func enviarRegistroCivil(id: Int, registro: String) {
        post(path: "/api/formularios/\(id)/registro-civil", body: ["registro": registro])
    }

    // MARK: - Seção 5
    func enviarNupcialidade(id: Int, possuiConjuge: String, vivemEmCompanhia: String, nomeConjuge: String, tipoUniao: String) {
        let body: [String: Any] = [
            "possui_conjuge": possuiConjuge,
            "vive_em_companhia": vivemEmCompanhia,
            "nome_conjuge": nomeConjuge,
            "tipo_uniao": tipoUniao
        ]
        post(path: "/api/formularios/\(id)/nupcialidade", body: body)
    }

    // MARK: - Seção 6
    func enviarTrabalho(id: Int, trabalhouRemunerado: String, quantidadeTrabalhos: String, ocupacao: String, atividadePrincipal: String, carteiraAssinada: String, possuiCNPJ: String, faixaRendimento: String) {
        let body: [String: Any] = [
            "trabalhou_remunerado": trabalhouRemunerado,
            "quantidade_trabalhos": quantidadeTrabalhos,
            "ocupacao": ocupacao,
            "atividade_principal": atividadePrincipal,
            "carteira_assinada": carteiraAssinada,
            "possui_cnpj": possuiCNPJ,
            "faixa_rendimento": faixaRendimento
        ]
        post(path: "/api/formularios/\(id)/trabalho", body: body)
    }

    // MARK: - Seção 7
    func enviarMortalidade(id: Int, houveFalecimento: String, dataFalecimento: String?, nomeFalecido: String?, idadeFalecido: String?, sexoFalecido: String?) {
        var body: [String: Any] = ["houve_falecimento": houveFalecimento]
        if let v = dataFalecimento  { body["data_falecimento"] = v }
        if let v = nomeFalecido     { body["nome_falecido"] = v }
        if let v = idadeFalecido    { body["idade_falecido"] = v }
        if let v = sexoFalecido     { body["sexo_falecido"] = v }
        post(path: "/api/formularios/\(id)/mortalidade", body: body)
    }

    // MARK: - Seção 8
    func enviarDeficiencia(id: Int, enxergar: String, ouvir: String, andar: String) {
        let body: [String: Any] = [
            "dificuldade_enxergar": enxergar,
            "dificuldade_ouvir": ouvir,
            "dificuldade_andar": andar
        ]
        post(path: "/api/formularios/\(id)/deficiencia", body: body)
    }

    // MARK: - Seção 9
    func enviarEducacao(id: Int, pessoasSabemLer: String, frequentaEscola: String, cursoFrequentado: String, concluiuSuperior: String) {
        let body: [String: Any] = [
            "pessoas_sabem_ler_escrever": pessoasSabemLer,
            "frequenta_escola": frequentaEscola,
            "curso_frequentado": cursoFrequentado,
            "concluiu_outro_superior": concluiuSuperior
        ]
        post(path: "/api/formularios/\(id)/educacao", body: body)
    }

    // MARK: - Seção 10
    func enviarDeslocamento(id: Int, algumMoradorTrabalha: String, municipio: String, retorna3Dias: String, tempoMinutos: Int, meioTransporte: String) {
        let body: [String: Any] = [
            "algum_morador_trabalha": algumMoradorTrabalha,
            "municipio_pais_trabalho": municipio,
            "retorna_3_dias_mais": retorna3Dias,
            "tempo_deslocamento_min": tempoMinutos,
            "meio_transporte": meioTransporte
        ]
        post(path: "/api/formularios/\(id)/deslocamento", body: body)
    }

    // MARK: - Seção 11
    func enviarReligiao(id: Int, religiao: String) {
        post(path: "/api/formularios/\(id)/religiao", body: ["religiao": religiao])
    }

    // MARK: - Seção 12
    func enviarAutismo(id: Int, diagnosticado: String) {
        post(path: "/api/formularios/\(id)/autismo", body: ["diagnosticado_autismo": diagnosticado])
    }

    // MARK: - Helper interno
    private func post(path: String, body: [String: Any]) {
        guard let url = URL(string: "\(baseURL)\(path)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONSerialization.data(withJSONObject: body)
        URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                print("❌ Erro ao enviar \(path): \(error)")
            } else if let r = response as? HTTPURLResponse {
                print("✅ \(path) → \(r.statusCode)")
            }
        }.resume()
    }
}
//teste
