    import SwiftUI

    struct MainGameView: View {
        @ObservedObject var gameSession: MultipeerConnector

        var body: some View {
            GeometryReader { geometry in
                let cellSize = min(geometry.size.width / 2, geometry.size.height / 2)
                let scoreFontSize = max(36, cellSize * 0.28)
                let buttonFontSize = max(28, cellSize * 0.18)

                LazyVGrid(
                    columns: [
                        GridItem(.flexible(), spacing: 12),
                        GridItem(.flexible(), spacing: 12)
                    ],
                    spacing: 12
                ) {
                    ForEach(0..<4) { index in
                        VStack(spacing: 12) {
                            Button {
                                gameSession.requestLifeChange(index: index, delta: 1)
                            } label: {
                                Text("+")
                                    .font(.system(size: buttonFontSize, weight: .bold))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }

                            Text("\(gameSession.gameState.totals[index])")
                                .font(.system(size: scoreFontSize, weight: .bold))
                                .minimumScaleFactor(0.5)
                                .frame(maxWidth: .infinity)

                            Button {
                                gameSession.requestLifeChange(index: index, delta: -1)
                            } label: {
                                Text("−")
                                    .font(.system(size: buttonFontSize, weight: .bold))
                                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                            }
                        }
                        .buttonStyle(.borderedProminent)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
                    }
                }
                .padding()
                .frame(
                    width: geometry.size.width,
                    height: geometry.size.height
                )
            }
        }
    }
