import SwiftUI

struct ContentView: View {
    let tipPercentages: [Int] = [15, 18, 20, 25, 0]
    @State private var selectedTip: Int = 18 // @State property wrapper is used to create a two-way binding
    @State private var writtenTip: Int = 0
    @State private var checkAmount: Double = 0.0
    @State private var numberOfPeople: Int = 2
    @State private var totalAmount: Double = 0.0
    
    var splitbill: Double {
        return checkAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "CAD"))
                    .keyboardType(.decimalPad)
                }

                Section(header: Text("Number of people")) {
                    TextField("Number of people", value: $numberOfPeople, format: .number)

                }

                Section(header: Text("Tip Percentage")) {
                    Picker("Tips", selection: $selectedTip) {
                        ForEach(tipPercentages, id: \.self) { tip in
                        Text("\(tip)%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    TextField("Tip Percentage", value: writtenTip != 0 ? $writtenTip : $selectedTip, format: .number) // If writtenTip is not 0, then use writtenTip, else use selectedTip
                    .keyboardType(.decimalPad) 
                }
                
                Section(header: Text("Total per person")) {
                    Text(String(format: "%.2f", splitbill + (splitbill * Double(selectedTip) / 100))) // %.2f means a floating-point number with two digits after the decimal point
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
