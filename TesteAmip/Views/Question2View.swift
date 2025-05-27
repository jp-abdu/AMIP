import SwiftUI

struct Question2View: View {
    @State private var numeroMoradores = ""
    @State private var nomeCompleto = ""
    @State private var dataNascimento = ""
    @State private var sexoSelecionado = ""
    @State private var parentescoSelecionado = ""
    @State private var situacaoDomicilioSelecionada = ""
    
    let opcoesSexo = ["Masculino", "Feminino"]
    
    let opcoesParentesco = [
        "Cônjuge ou companheiro(a) de sexo diferente",
        "Cônjuge ou companheiro(a) do mesmo sexo",
        "Filho(a) do responsável e do cônjuge",
        "Filho(a) somente do responsável",
        "Genro ou nora",
        "Pai, mãe, padrasto ou madrasta",
        "Sogro(a)",
        "Neto(a)",
        "Enteado(a)",
        "Irmão ou irmã",
        "Avô ou avó",
        "Empregado(a) doméstico(a)",
        "Parente do(a) empregado(a) doméstico(a)",
        "Individual em domicílio coletivo",
        "Outros"
    ]
    
    let opcoesSituacaoDomicilio = [
        "Próprio de algum morador cedido ou emprestado",
        "Ainda pagando",
        "Alugado",
        "Por empregador",
        "Por familiar",
        "Já pago, herdado ou ganho",
        "Outra forma"
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            HeaderView()
            
            ScrollView {
                VStack(spacing: 20) {
                    
                    Text("2. INFORMAÇÕES SOBRE OS MORADORES")
                        .font(.system(size: 23))
                        .bold()
                        .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 7.5)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Quantas pessoas moram na residência?")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "", text: $numeroMoradores, keyboardType: .numberPad)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Nome completo, data de nascimento e sexo:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        LabeledTextFieldViews(title: "Nome Completo", text: $nomeCompleto)
                        LabeledTextFieldViews(title: "00/00/0000", text: $dataNascimento, keyboardType: .numbersAndPunctuation)
                        
                        RadioGroupViews(options: opcoesSexo, selected: $sexoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Relação de parentesco com a pessoa responsável pelo domicílio")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesParentesco, selected: $parentescoSelecionado)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Este domicílio é:")
                            .font(.headline)
                            .foregroundColor(Color(red: 0.0, green: 0.3, blue: 0.3))
                        
                        RadioGroupViews(options: opcoesSituacaoDomicilio, selected: $situacaoDomicilioSelecionada)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color(red: 218/255, green: 249/255, blue: 254/255))
                    .cornerRadius(20)
                    
                    FormNavigationButtonsRows(
                        backDestination: Question1View(),
                        nextDestination: Question3View()
                    )
                }
                .padding()
            }
        }
        .navigationBarHidden(true)
    }
}

struct Question2View_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            Question2View()
        }
    }
}
