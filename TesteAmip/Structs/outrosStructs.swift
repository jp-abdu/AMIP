import SwiftUI
//tava dando problema com o nome botei um s no final desse struct, sepa todos os structs temq ter nome diferente

struct LabeledTextFieldViews: View {
    let title: String
    @Binding var text: String
    var keyboardType: UIKeyboardType = .default

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.subheadline)

            TextField("", text: $text)
                .keyboardType(keyboardType)
                .padding(8)
                .background(Color.white)
                .cornerRadius(8)
        }
    }
}

//tava dando problema com o nome botei um s no final desse struct, sepa todos os structs temq ter nome diferente
struct RadioGroupViews: View {
    let options: [String]
    @Binding var selected: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            ForEach(options, id: \.self) { option in
                HStack(spacing: 12) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 25, height: 25)
                            .overlay(
                                Circle()
                                    .stroke(Color.black, lineWidth: 1)
                            )

                        if selected == option {
                            Circle()
                                .fill(Color.blue)
                                .frame(width: 10, height: 10)
                        }
                    }

                    Text(option)
                        .foregroundColor(.black)
                        .font(.system(size: 17))
                        .fixedSize(horizontal: false, vertical: true)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selected = option
                }
            }
        }
    }
}
