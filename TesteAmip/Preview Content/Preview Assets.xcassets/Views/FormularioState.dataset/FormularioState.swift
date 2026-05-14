import SwiftUI

class FormularioState: ObservableObject {

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
}
