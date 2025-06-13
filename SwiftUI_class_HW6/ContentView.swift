import SwiftUI

struct MahjongHand {
    let name: String
    let tai: String
}

struct ContentView: View {
    @State private var selectedHands: Set<String> = []
    @State private var baseTai: String = "3"
    @State private var taiValue: String = "10"
    @State private var N: String = "0"

    var totalTai: Int {
        var total = Int(baseTai) ?? 0
        for hand in hands {
            if selectedHands.contains(hand.name) {
                if hand.name == "連N拉N" {
                    total += 2 * (Int(N) ?? 0) + 1
                } else {
                    total += Int(hand.tai) ?? 0
                }
            }
        }
        return total
    }

    var totalAmount: Int {
        totalTai * (Int(taiValue) ?? 0)
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    HandSelectionSection(hands: hands, selectedHands: $selectedHands, N: $N)
                    InputSection(baseTai: $baseTai, taiValue: $taiValue, N: $N)
                    ResultSection(totalTai: totalTai, totalAmount: totalAmount)
                    ClearButtonSection(selectedHands: $selectedHands, baseTai: $baseTai, taiValue: $taiValue, N: $N)
                }
                .padding()
            }
//            .navigationTitle("台灣麻將計算機")
            .navigationTitle("") // 清空預設 title
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Image("mahjong")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                        Text("台灣麻將計算機")
                            .font(.title)
                            .bold()
                    }
                }
            }
            .background(
                Image("mahjong_background")
                    .resizable()
                    .scaledToFill()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .ignoresSafeArea()
            )
        }
    }
}

struct HandSelectionSection: View {
    let hands: [MahjongHand]
    @Binding var selectedHands: Set<String>
    @Binding var N: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("選擇胡的牌型")
                .font(.headline)
            ForEach(hands, id: \.name) { hand in
                Button {
                    if selectedHands.contains(hand.name) {
                        selectedHands.remove(hand.name)
                    } else {
                        selectedHands.insert(hand.name)
                    }
                } label: {
                    HStack {
                        Text(hand.name)
                        Spacer()
                        Text("\(hand.tai)台")
                        if selectedHands.contains(hand.name) {
                            Image(systemName: "checkmark.circle.fill")
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                    .contentShape(Rectangle())
                }
                .buttonStyle(PlainButtonStyle())
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct InputSection: View {
    @Binding var baseTai: String
    @Binding var taiValue: String
    @Binding var N: String

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("輸入資訊")
                .font(.headline)
            InputRow(label: "底台", text: $baseTai)
            InputRow(label: "每台金額 (TWD)", text: $taiValue)
            InputRow(label: "連莊數 N", text: $N)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct InputRow: View {
    let label: String
    @Binding var text: String

    var body: some View {
        HStack {
            Text(label)
            Spacer()
            TextField(label, text: $text)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.trailing)
                .frame(width: 100)
                .textFieldStyle(.roundedBorder)
        }
    }
}

struct ResultSection: View {
    let totalTai: Int
    let totalAmount: Int

    var body: some View {
        VStack(spacing: 8) {
            Text("總台數：\(totalTai) 台")
                .font(.title3)
            Text("應付金額：\(totalAmount) TWD")
                .font(.title)
                .bold()
                .foregroundColor(.blue)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(12)
        .shadow(radius: 3)
    }
}

struct ClearButtonSection: View {
    @Binding var selectedHands: Set<String>
    @Binding var baseTai: String
    @Binding var taiValue: String
    @Binding var N: String

    var body: some View {
        Button("清空所有選擇") {
            selectedHands.removeAll()
            baseTai = "3"
            taiValue = "10"
            N = "0"
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.red.opacity(0.9))
        .foregroundColor(.white)
        .cornerRadius(12)
        .shadow(radius: 2)
    }
}

let hands: [MahjongHand] = [
    MahjongHand(name: "連N拉N", tai: "2N+1"),
    MahjongHand(name: "單吊", tai: "1"),
    MahjongHand(name: "中洞", tai: "1"),
    MahjongHand(name: "邊張", tai: "1"),
    MahjongHand(name: "自摸", tai: "1"),
    MahjongHand(name: "門清", tai: "1"),
    MahjongHand(name: "自摸門清", tai: "3"),
    MahjongHand(name: "全求人", tai: "2"),
    MahjongHand(name: "半求人", tai: "1"),
    MahjongHand(name: "天胡", tai: "24"),
    MahjongHand(name: "地胡", tai: "16"),
    MahjongHand(name: "碰碰胡", tai: "4"),
    MahjongHand(name: "平胡", tai: "2"),
    MahjongHand(name: "大四喜", tai: "16"),
    MahjongHand(name: "小四喜", tai: "8"),
    MahjongHand(name: "大三元", tai: "8"),
    MahjongHand(name: "小三元", tai: "4"),
    MahjongHand(name: "五暗刻", tai: "8"),
    MahjongHand(name: "四暗刻", tai: "5"),
    MahjongHand(name: "三暗刻", tai: "2"),
    MahjongHand(name: "清一色", tai: "8"),
    MahjongHand(name: "混一色 / 湊一色", tai: "4"),
    MahjongHand(name: "槓上開花", tai: "1"),
    MahjongHand(name: "搶槓", tai: "1"),
    MahjongHand(name: "海底撈月", tai: "1"),
    MahjongHand(name: "海底撈魚", tai: "1"),
    MahjongHand(name: "正花 / 花牌", tai: "1"),
    MahjongHand(name: "門風", tai: "1"),
    MahjongHand(name: "圈風", tai: "1"),
    MahjongHand(name: "天聽", tai: "8"),
    MahjongHand(name: "地聽", tai: "4"),
    MahjongHand(name: "不求人", tai: "1"),
    MahjongHand(name: "人胡", tai: "8"),
    MahjongHand(name: "三元刻", tai: "1"),
    MahjongHand(name: "字一色", tai: "16"),
    MahjongHand(name: "八仙過海", tai: "8"),
    MahjongHand(name: "七搶一", tai: "8"),
    MahjongHand(name: "花槓", tai: "1"),
]

#Preview {
    ContentView()
}
