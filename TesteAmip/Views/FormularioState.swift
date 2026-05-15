import SwiftUI

class FormularioState: ObservableObject {
    
    // MARK: - Controle de Navegação Global
        @Published var isFormularioAtivo: Bool = false

    // MARK: - Q1: Identificação de Domicílio
    @Published var q1_ruaSelecionada: String = ""
    @Published var q1_numero: String = ""
    @Published var q1_complemento: String = ""
    @Published var q1_especieSelecionada: String = ""
    @Published var q1_tipoSelecionado: String = ""

    // MARK: - Q2: Informações sobre os Moradores
    @Published var q2_numeroMoradores: String = ""
    @Published var q2_nomeCompleto: String = ""
    @Published var q2_dataNascimento: Date = Date()
    @Published var q2_dataNascimentoSelecionada: Bool = false
    @Published var q2_sexoSelecionado: String = ""
    @Published var q2_parentescoSelecionado: String = ""
    @Published var q2_situacaoDomicilioSelecionada: String = ""
    @Published var q2_datasNascimentoMoradores: [String] = []
    @Published var q2_datasAdicionais: [Date] = []

    // MARK: - Q3: Características do Domicílio
    @Published var q3_quantidadeComodos: String = ""
    @Published var q3_quantidadeDormitorios: String = ""
    @Published var q3_quantidadeBanheirosCom: String = ""
    @Published var q3_quantidadeBanheirosSem: String = ""
    @Published var q3_acessoInternet: String = ""
    @Published var q3_possuiMaquinaLavar: String = ""

    // MARK: - Q4: Registro Civil
    @Published var q4_respostaSelecionada: String = ""

    // MARK: - Q5: Nupcialidade
    @Published var q5_possuiConjugeOuCompanheiro: String = ""
    @Published var q5_vivemEmCompanhia: String = ""
    @Published var q5_nomeConjugeCompanheiro: String = ""
    @Published var q5_tipoUniao: String = ""

    // MARK: - Q6: Trabalho e Rendimento
    @Published var q6_trabalhouRemunerado: String = ""
    @Published var q6_quantidadeTrabalhos: String = ""
    @Published var q6_ocupacao: String = ""
    @Published var q6_atividadePrincipal: String = ""
    @Published var q6_carteiraAssinada: String = ""
    @Published var q6_possuiCNPJ: String = ""
    @Published var q6_faixaRendimento: String = ""

    // MARK: - Q7: Taxa de Mortalidade
    @Published var q7_faleceuPessoa: String = ""
    @Published var q7_dataFalecimento: Date = Date()
    @Published var q7_nomeCompletoFalecido: String = ""
    @Published var q7_idadeFalecido: String = ""
    @Published var q7_sexoFalecido: String = ""

    // MARK: - Q8: Pessoas com Deficiência
    @Published var q8_dificuldadeEnxergar: String = ""
    @Published var q8_dificuldadeOuvir: String = ""
    @Published var q8_dificuldadeAndar: String = ""

    // MARK: - Q9: Educação
    @Published var q9_pessoasSabemLerEscrever: String = "Selecione"
    @Published var q9_frequentaEscolaCreche: String = ""
    @Published var q9_cursoQueFrequenta: String = ""
    @Published var q9_concluiuOutroSuperior: String = ""

    // MARK: - Q10: Deslocamento para Trabalho
    @Published var q10_algumMoradorTrabalha: String = ""
    @Published var q10_municipioPaisTrabalho: String = ""
    @Published var q10_retornaTrabalho3DiasMais: String = ""
    @Published var q10_tempoDeslocamento: Double = 0.0
    @Published var q10_meioTransporte: String = ""

    // MARK: - Q11: Religião
    @Published var q11_religiaoSelecionada: String = ""

    // MARK: - Q12: Autismo
    @Published var q12_diagnosticadoComAutismo: String = ""
    
    // MARK: - Reset do Formulário
    func limparFormulario() {
        // Q1
        q1_ruaSelecionada = ""
        q1_numero = ""
        q1_complemento = ""
        q1_especieSelecionada = ""
        q1_tipoSelecionado = ""
        
        // Q2
        q2_numeroMoradores = ""
        q2_nomeCompleto = ""
        q2_dataNascimento = Date()
        q2_dataNascimentoSelecionada = false
        q2_sexoSelecionado = ""
        q2_parentescoSelecionado = ""
        q2_situacaoDomicilioSelecionada = ""
        q2_datasNascimentoMoradores = [] // <--- Corrigido aqui
        q2_datasAdicionais = []          // <--- Corrigido aqui
        
        // Q3
        q3_quantidadeComodos = ""
        q3_quantidadeDormitorios = ""
        q3_quantidadeBanheirosCom = ""
        q3_quantidadeBanheirosSem = ""
        q3_acessoInternet = ""
        q3_possuiMaquinaLavar = ""
        
        // Q4
        q4_respostaSelecionada = ""
        
        // Q5
        q5_possuiConjugeOuCompanheiro = ""
        q5_vivemEmCompanhia = ""
        q5_nomeConjugeCompanheiro = ""
        q5_tipoUniao = ""
        
        // Q6
        q6_trabalhouRemunerado = ""
        q6_quantidadeTrabalhos = ""
        q6_ocupacao = ""
        q6_atividadePrincipal = ""
        q6_carteiraAssinada = ""
        q6_possuiCNPJ = ""
        q6_faixaRendimento = ""
        
        // Q7
        q7_faleceuPessoa = ""
        q7_dataFalecimento = Date()
        q7_nomeCompletoFalecido = ""
        q7_idadeFalecido = ""
        q7_sexoFalecido = ""
        
        // Q8
        q8_dificuldadeEnxergar = ""
        q8_dificuldadeOuvir = ""
        q8_dificuldadeAndar = ""
        
        // Q9
        q9_pessoasSabemLerEscrever = "Selecione"
        q9_frequentaEscolaCreche = ""
        q9_cursoQueFrequenta = ""
        q9_concluiuOutroSuperior = ""
        
        // Q10
        q10_algumMoradorTrabalha = ""
        q10_municipioPaisTrabalho = ""
        q10_retornaTrabalho3DiasMais = ""
        q10_tempoDeslocamento = 0.0
        q10_meioTransporte = ""
        
        // Q11 e Q12
        q11_religiaoSelecionada = ""
        q12_diagnosticadoComAutismo = ""
    }
    
    // MARK: - Envio em Lote (Batch Send) com Validação Estrita
        func enviarDadosParaAPI(formularioId: Int) {
            let formatter = DateFormatter()
            formatter.dateFormat = "dd/MM/yyyy"
            
            // Q1 - Domicílio
            if !q1_ruaSelecionada.isEmpty && q1_ruaSelecionada != "Selecione a Rua" {
                APIService.shared.enviarDomicilio(id: formularioId, rua: q1_ruaSelecionada, numero: q1_numero, complemento: q1_complemento, especie: q1_especieSelecionada, tipo: q1_tipoSelecionado)
            }
            
            // Q2 - Moradores
            if !q2_nomeCompleto.isEmpty || !q2_numeroMoradores.isEmpty {
                // Só formata a data de nascimento principal se ela realmente foi selecionada
                let dataNasc = q2_dataNascimentoSelecionada ? formatter.string(from: q2_dataNascimento) : ""
                
                var todasAsDatas: [String] = []
                if q2_dataNascimentoSelecionada { todasAsDatas.append(dataNasc) }
                todasAsDatas.append(contentsOf: q2_datasAdicionais.map { formatter.string(from: $0) })
                
                APIService.shared.enviarMoradores(id: formularioId, numeroMoradores: Int(q2_numeroMoradores) ?? 1, nomeCompleto: q2_nomeCompleto, dataNascimento: dataNasc, datasNascimentoMoradores: todasAsDatas, sexo: q2_sexoSelecionado, parentesco: q2_parentescoSelecionado, situacaoDomicilio: q2_situacaoDomicilioSelecionada)
            }
            
            // Q3 - Características
            if !q3_quantidadeComodos.isEmpty {
                APIService.shared.enviarCaracteristicas(id: formularioId, comodos: q3_quantidadeComodos, dormitorios: q3_quantidadeDormitorios, banheirosCom: q3_quantidadeBanheirosCom, banheirosSem: q3_quantidadeBanheirosSem, internet: q3_acessoInternet, maquinaLavar: q3_possuiMaquinaLavar)
            }
            
            // Q4 - Registro Civil
            if !q4_respostaSelecionada.isEmpty {
                APIService.shared.enviarRegistroCivil(id: formularioId, registro: q4_respostaSelecionada)
            }
            
            // Q5 - Nupcialidade
            if !q5_possuiConjugeOuCompanheiro.isEmpty {
                let vivem = q5_possuiConjugeOuCompanheiro == "Sim" ? q5_vivemEmCompanhia : ""
                let nome = q5_possuiConjugeOuCompanheiro == "Sim" ? q5_nomeConjugeCompanheiro : ""
                let tipo = q5_possuiConjugeOuCompanheiro == "Sim" ? q5_tipoUniao : ""
                
                APIService.shared.enviarNupcialidade(id: formularioId, possuiConjuge: q5_possuiConjugeOuCompanheiro, vivemEmCompanhia: vivem, nomeConjuge: nome, tipoUniao: tipo)
            }
            
            // Q6 - Trabalho
            if !q6_trabalhouRemunerado.isEmpty {
                let qtd = q6_trabalhouRemunerado == "Sim" ? q6_quantidadeTrabalhos : ""
                let ocup = q6_trabalhouRemunerado == "Sim" ? q6_ocupacao : ""
                let ativ = q6_trabalhouRemunerado == "Sim" ? q6_atividadePrincipal : ""
                let cart = q6_trabalhouRemunerado == "Sim" ? q6_carteiraAssinada : ""
                let cnpj = q6_trabalhouRemunerado == "Sim" ? q6_possuiCNPJ : ""
                
                APIService.shared.enviarTrabalho(id: formularioId, trabalhouRemunerado: q6_trabalhouRemunerado, quantidadeTrabalhos: qtd, ocupacao: ocup, atividadePrincipal: ativ, carteiraAssinada: cart, possuiCNPJ: cnpj, faixaRendimento: q6_faixaRendimento)
            }
            
            // Q7 - Mortalidade
            if !q7_faleceuPessoa.isEmpty {
                // Limpa dados fantasmas caso o usuário tenha marcado "Não"
                let dataFalecimento = q7_faleceuPessoa == "Sim" ? formatter.string(from: q7_dataFalecimento) : nil
                let nome = q7_faleceuPessoa == "Sim" ? q7_nomeCompletoFalecido : nil
                let idade = q7_faleceuPessoa == "Sim" ? q7_idadeFalecido : nil
                let sexo = q7_faleceuPessoa == "Sim" ? q7_sexoFalecido : nil
                
                APIService.shared.enviarMortalidade(id: formularioId, houveFalecimento: q7_faleceuPessoa, dataFalecimento: dataFalecimento, nomeFalecido: nome, idadeFalecido: idade, sexoFalecido: sexo)
            }
            
            // Q8 - Deficiência
            if !q8_dificuldadeEnxergar.isEmpty {
                APIService.shared.enviarDeficiencia(id: formularioId, enxergar: q8_dificuldadeEnxergar, ouvir: q8_dificuldadeOuvir, andar: q8_dificuldadeAndar)
            }
            
            // Q9 - Educação
            if q9_pessoasSabemLerEscrever != "Selecione" && !q9_pessoasSabemLerEscrever.isEmpty {
                let curso = (q9_frequentaEscolaCreche == "Sim" || q9_frequentaEscolaCreche == "Não, mas já frequentou") ? q9_cursoQueFrequenta : ""
                let concluiu = (q9_frequentaEscolaCreche == "Sim" || q9_frequentaEscolaCreche == "Não, mas já frequentou") ? q9_concluiuOutroSuperior : ""
                
                APIService.shared.enviarEducacao(id: formularioId, pessoasSabemLer: q9_pessoasSabemLerEscrever, frequentaEscola: q9_frequentaEscolaCreche, cursoFrequentado: curso, concluiuSuperior: concluiu)
            }
            
            // Q10 - Deslocamento
            if !q10_algumMoradorTrabalha.isEmpty {
                let mun = q10_algumMoradorTrabalha == "Sim" ? q10_municipioPaisTrabalho : ""
                let ret = q10_algumMoradorTrabalha == "Sim" ? q10_retornaTrabalho3DiasMais : ""
                let min = q10_algumMoradorTrabalha == "Sim" ? Int(q10_tempoDeslocamento) : 0
                let trans = q10_algumMoradorTrabalha == "Sim" ? q10_meioTransporte : ""
                
                APIService.shared.enviarDeslocamento(id: formularioId, algumMoradorTrabalha: q10_algumMoradorTrabalha, municipio: mun, retorna3Dias: ret, tempoMinutos: min, meioTransporte: trans)
            }
            
            // Q11 - Religião
            if !q11_religiaoSelecionada.isEmpty {
                APIService.shared.enviarReligiao(id: formularioId, religiao: q11_religiaoSelecionada)
            }
            
            // Q12 - Autismo
            if !q12_diagnosticadoComAutismo.isEmpty {
                APIService.shared.enviarAutismo(id: formularioId, diagnosticado: q12_diagnosticadoComAutismo)
            }
        }
    
    // MARK: - Orquestrador de Envio (Mestre)
    func salvarFormularioNoBackend(finalizar: Bool, completion: @escaping (Bool) -> Void) {
        // 1. Pede um novo ID para a API
        APIService.shared.criarFormulario { novoId in
            guard let id = novoId else {
                print("❌ Erro ao criar o ID do formulário no backend.")
                // Retorna para a tela principal (Thread da UI) que falhou
                DispatchQueue.main.async { completion(false) }
                return
            }
            
            // 2. Salva o ID globalmente por segurança
            DispatchQueue.main.async {
                FormularioManager.shared.formularioId = id
            }
            
            // 3. Dispara as até 12 requisições em lote!
            self.enviarDadosParaAPI(formularioId: id)
            
            // 4. Se for um envio completo (não um cancelamento salvo pela metade), finaliza a data/hora
            if finalizar {
                APIService.shared.finalizarFormulario(id: id)
            }
            
            // 5. Retorna sucesso para a interface trocar de tela
            DispatchQueue.main.async {
                completion(true)
            }
        }
    }
}
