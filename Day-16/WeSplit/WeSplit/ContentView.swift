import SwiftUI

struct ContentView: View {
    let tipPercentages: [String] = ["15%", "18%", "20%", "25%", "Other"]
    @State private var selectedTipIndex: Int = 0 // @State property wrapper is used to create a two-way binding
    @State private var writtenTip: Int = 0
    @State private var checkAmountText: String = ""
    @State private var numberOfPeopleText: String = ""
    @State private var totalAmount: Double = 0.0

    var checkAmount: Double {
        return Double(checkAmountText) ?? 0
    }
    
    var numberOfPeople: Int {
        return Int(numberOfPeopleText) ?? 1
    }
    
    var splitBill: Double {
        return checkAmount / Double(numberOfPeople)
    }
    
    var body: some View {
        NavigationView {
          Form {
                Section(header: Text("Enter the bill details")) {
                    TextField("Amount", text: $checkAmountText)
                        .keyboardType(.decimalPad)
                    TextField("Number of people", text: $numberOfPeopleText)
                        .keyboardType(.numberPad)
                }

                Section(header: Text("Tip Percentage")) {
                    Picker("Tips", selection: $selectedTipIndex) {
                        ForEach(0..<tipPercentages.count, id: \.self) { index in
                            Text(tipPercentages[index])
                                .tag(index)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    
                    // if selectedTip is Other, show TextField
                    if selectedTipIndex == tipPercentages.count - 1 {
                        TextField("Tip Percentage", value: $writtenTip, format: .number)
                            .keyboardType(.numberPad)
                    }
                }
                
                Section(header: Text("Total per person")) {
                    Text(String(format: "%.2f", splitBill + (splitBill * Double(getSelectedTip()) / 100))) // %.2f means a floating-point number with two digits after the decimal point
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
    
    func getSelectedTip() -> Int {
        if selectedTipIndex == tipPercentages.count - 1 {
            return writtenTip
        } else {
            return Int(tipPercentages[selectedTipIndex].dropLast()) ?? 0
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
