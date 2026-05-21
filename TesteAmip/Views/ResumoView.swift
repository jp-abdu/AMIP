import SwiftUI

struct ResumoView: View {
    @EnvironmentObject var estado: FormularioState
    @State private var enviando = false
    @State private var navegarParaSucesso = false
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd/MM/yyyy"
        return formatter
    }
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView() // Assumindo que HeaderView já está definida
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    // GRUPO 1: Cabeçalho e Perguntas 1 a 4
                    Group {
                        Text("RESUMO DAS RESPOSTAS")
                            .font(.system(size: 23))
                            .bold()
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.leading, 7.5)
                        
                        Text("Revise os dados antes de enviar.")
                            .font(.subheadline)
                            .foregroundColor(.gray)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.horizontal, 7.5)
                        
                        // MARK: - 1. IDENTIFICAÇÃO DE DOMICÍLIO
                        CartaoResumo(titulo: "1. IDENTIFICAÇÃO DE DOMICÍLIO") {
                            ResumoRowView(pergunta: "Rua:", resposta: estado.q1_ruaSelecionada)
                            ResumoRowView(pergunta: "Número:", resposta: estado.q1_numero)
                            if !estado.q1_complemento.isEmpty {
                                ResumoRowView(pergunta: "Complemento:", resposta: estado.q1_complemento)
                            }
                            ResumoRowView(pergunta: "Espécie:", resposta: estado.q1_especieSelecionada)
                            ResumoRowView(pergunta: "Tipo:", resposta: estado.q1_tipoSelecionado)
                        }
                        
                        // MARK: - 2. INFORMAÇÕES SOBRE OS MORADORES
                        CartaoResumo(titulo: "2. INFORMAÇÕES SOBRE OS MORADORES") {
                            ResumoRowView(pergunta: "Total de Moradores:", resposta: estado.q2_numeroMoradores)
                            ResumoRowView(pergunta: "Entrevistado:", resposta: estado.q2_nomeCompleto)
                            ResumoRowView(pergunta: "Nascimento:", resposta: dateFormatter.string(from: estado.q2_dataNascimento))
                            ResumoRowView(pergunta: "Sexo:", resposta: estado.q2_sexoSelecionado)
                            ResumoRowView(pergunta: "Parentesco:", resposta: estado.q2_parentescoSelecionado)
                            ResumoRowView(pergunta: "Situação do Domicílio:", resposta: estado.q2_situacaoDomicilioSelecionada)
                            
                            if !estado.q2_datasAdicionais.isEmpty {
                                Divider().padding(.vertical, 4)
                                Text("Outros Moradores:")
                                    .font(.caption)
                                    .bold()
                                ForEach(0..<estado.q2_datasAdicionais.count, id: \.self) { index in
                                    ResumoRowView(pergunta: "Morador \(index + 2):", resposta: dateFormatter.string(from: estado.q2_datasAdicionais[index]))
                                }
                            }
                        }
                        
                        // MARK: - 3. CARACTERÍSTICAS DO DOMICÍLIO
                        CartaoResumo(titulo: "3. CARACTERÍSTICAS DO DOMICÍLIO") {
                            ResumoRowView(pergunta: "Cômodos:", resposta: estado.q3_quantidadeComodos)
                            ResumoRowView(pergunta: "Dormitórios:", resposta: estado.q3_quantidadeDormitorios)
                            ResumoRowView(pergunta: "Banheiros (Com Chuveiro):", resposta: estado.q3_quantidadeBanheirosCom)
                            ResumoRowView(pergunta: "Banheiros (Sem Chuveiro):", resposta: estado.q3_quantidadeBanheirosSem)
                            ResumoRowView(pergunta: "Acesso à Internet:", resposta: estado.q3_acessoInternet)
                            ResumoRowView(pergunta: "Máquina de Lavar:", resposta: estado.q3_possuiMaquinaLavar)
                        }
                        
                        // MARK: - 4. REGISTRO CIVIL
                        CartaoResumo(titulo: "4. REGISTRO CIVIL") {
                            ResumoRowView(pergunta: "Possui Registro:", resposta: estado.q4_respostaSelecionada)
                        }
                    } // Fim do Grupo 1
                    
                    // GRUPO 2: Perguntas 5 a 9
                    Group {
                        // MARK: - 5. NUPCIALIDADE
                        CartaoResumo(titulo: "5. NUPCIALIDADE") {
                            ResumoRowView(pergunta: "Cônjuge/Companheiro?", resposta: estado.q5_possuiConjugeOuCompanheiro)
                            if estado.q5_possuiConjugeOuCompanheiro == "Sim" {
                                ResumoRowView(pergunta: "Vivem juntos?", resposta: estado.q5_vivemEmCompanhia)
                                ResumoRowView(pergunta: "Nome do Cônjuge:", resposta: estado.q5_nomeConjugeCompanheiro)
                                ResumoRowView(pergunta: "Tipo de União:", resposta: estado.q5_tipoUniao)
                            }
                        }
                        
                        // MARK: - 6. TRABALHO E RENDIMENTO
                        CartaoResumo(titulo: "6. TRABALHO E RENDIMENTO") {
                            ResumoRowView(pergunta: "Trabalhou Remunerado?", resposta: estado.q6_trabalhouRemunerado)
                            if estado.q6_trabalhouRemunerado == "Sim" {
                                ResumoRowView(pergunta: "Qtd Trabalhos:", resposta: estado.q6_quantidadeTrabalhos)
                                ResumoRowView(pergunta: "Ocupação:", resposta: estado.q6_ocupacao)
                                ResumoRowView(pergunta: "Atividade Principal:", resposta: estado.q6_atividadePrincipal)
                                ResumoRowView(pergunta: "Carteira Assinada?", resposta: estado.q6_carteiraAssinada)
                                ResumoRowView(pergunta: "Possui CNPJ?", resposta: estado.q6_possuiCNPJ)
                            }
                            Divider().padding(.vertical, 4)
                            ResumoRowView(pergunta: "Faixa de Rendimento:", resposta: estado.q6_faixaRendimento)
                        }
                        
                        // MARK: - 7. TAXA DE MORTALIDADE
                        CartaoResumo(titulo: "7. MORTALIDADE") {
                            ResumoRowView(pergunta: "Houve Falecimento?", resposta: estado.q7_faleceuPessoa)
                            if estado.q7_faleceuPessoa == "Sim" {
                                ResumoRowView(pergunta: "Nome:", resposta: estado.q7_nomeCompletoFalecido)
                                ResumoRowView(pergunta: "Data:", resposta: dateFormatter.string(from: estado.q7_dataFalecimento))
                                ResumoRowView(pergunta: "Idade:", resposta: estado.q7_idadeFalecido)
                                ResumoRowView(pergunta: "Sexo:", resposta: estado.q7_sexoFalecido)
                            }
                        }
                        
                        // MARK: - 8. PESSOAS COM DEFICIÊNCIA
                        CartaoResumo(titulo: "8. PESSOAS COM DEFICIÊNCIA") {
                            ResumoRowView(pergunta: "Enxergar:", resposta: estado.q8_dificuldadeEnxergar)
                            ResumoRowView(pergunta: "Ouvir:", resposta: estado.q8_dificuldadeOuvir)
                            ResumoRowView(pergunta: "Andar/Subir Degraus:", resposta: estado.q8_dificuldadeAndar)
                        }
                        
                        // MARK: - 9. EDUCAÇÃO
                        CartaoResumo(titulo: "9. EDUCAÇÃO") {
                            ResumoRowView(pergunta: "Sabem ler/escrever:", resposta: estado.q9_pessoasSabemLerEscrever)
                            ResumoRowView(pergunta: "Frequenta Escola?", resposta: estado.q9_frequentaEscolaCreche)
                            if estado.q9_frequentaEscolaCreche != "Não, nunca frequentou" {
                                ResumoRowView(pergunta: "Curso:", resposta: estado.q9_cursoQueFrequenta)
                                ResumoRowView(pergunta: "Concluiu Superior?", resposta: estado.q9_concluiuOutroSuperior)
                            }
                        }
                    } // Fim do Grupo 2
                    
                    // GRUPO 3: Perguntas Finais e Botões
                    Group {
                        // MARK: - 10. DESLOCAMENTO
                        CartaoResumo(titulo: "10. DESLOCAMENTO PARA TRABALHO") {
                            ResumoRowView(pergunta: "Morador Trabalha?", resposta: estado.q10_algumMoradorTrabalha)
                            if estado.q10_algumMoradorTrabalha == "Sim" {
                                ResumoRowView(pergunta: "Município/País:", resposta: estado.q10_municipioPaisTrabalho)
                                ResumoRowView(pergunta: "Retorna 3 dias+?", resposta: estado.q10_retornaTrabalho3DiasMais)
                                ResumoRowView(pergunta: "Tempo (Minutos):", resposta: "\(Int(estado.q10_tempoDeslocamento))")
                                ResumoRowView(pergunta: "Transporte:", resposta: estado.q10_meioTransporte)
                            }
                        }
                        
                        // MARK: - 11. RELIGIÃO E 12. AUTISMO
                        CartaoResumo(titulo: "11 E 12. RELIGIÃO E AUTISMO") {
                            ResumoRowView(pergunta: "Religião/Culto:", resposta: estado.q11_religiaoSelecionada)
                            ResumoRowView(pergunta: "Diagnóstico de Autismo:", resposta: estado.q12_diagnosticadoComAutismo)
                        }
                        
                        // MARK: - BOTÕES FINAIS COM CARREGAMENTO
                        VStack(spacing: 16) {
                            if enviando {
                                ProgressView("Enviando formulário ao servidor...")
                                    .padding()
                            } else {
                                Button(action: {
                                    enviando = true
                                    // O Mestre salva e finaliza
                                    estado.salvarFormularioNoBackend(finalizar: true) { sucesso in
                                        enviando = false
                                        if sucesso {
                                            navegarParaSucesso = true
                                        } else {
                                            print("Erro na conexão com a API")
                                        }
                                    }
                                }) {
                                    Text("Enviar Formulário")
                                        .frame(maxWidth: .infinity)
                                        .padding()
                                        .background(Color(red: 0/255, green: 104/255, blue: 150/255))
                                        .foregroundColor(.white)
                                        .cornerRadius(10)
                                }
                                
                                // Botão de voltar programático para a Q12
                                NavigationLink(destination: Question12View()) {
                                    Text("Voltar para revisar")
                                        .foregroundColor(Color(red: 0/255, green: 104/255, blue: 150/255))
                                        .underline()
                                }
                            }
                            
                            // Link oculto que dispara a tela de sucesso
                            NavigationLink(destination: FormularioEnviadoView(), isActive: $navegarParaSucesso) {
                                EmptyView()
                            }
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 30)
                    } // Fim do Grupo 3
                    
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

// MARK: - Componente Visual para o Cartão de Resumo
struct CartaoResumo<Content: View>: View {
    let titulo: String
    let content: Content
    
    init(titulo: String, @ViewBuilder content: () -> Content) {
        self.titulo = titulo
        self.content = content()
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(titulo)
                .font(.headline)
                .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            Divider()
            
            content
        }
        .padding()
        .background(Color(red: 218/255, green: 249/255, blue: 254/255))
        .cornerRadius(20)
    }
}

// MARK: - Componente Visual para a Linha (Pergunta/Resposta)
struct ResumoRowView: View {
    let pergunta: String
    let resposta: String
    
    var body: some View {
        HStack(alignment: .top) {
            Text(pergunta)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.black)
            
            Spacer()
            
            Text(resposta.isEmpty ? "Não respondido" : resposta)
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.trailing)
        }
    }
}

struct ResumoView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResumoView()
                .environmentObject(FormularioState())
        }
    }
}
