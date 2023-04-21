import SwiftUI
import AVFoundation

struct ContentView: View {
    @StateObject var player = AudioPlayer()
    @StateObject private var viewModel = MenuViewModel()
    
    var body: some View {
        NavigationView {
            List(viewModel.menuItems) { menuItem in
                NavigationLink(destination: menuItem.destinationView) {
                    HStack{
                        Text(menuItem.title)
                            .padding(20)
                        Spacer()
                        Image(systemName: menuItem.symbol)
                            .foregroundColor(.orange)
                    }
                }
            }
            .onAppear(perform: viewModel.loadMenuItems)
            .navigationBarTitle("Menu")
            ZStack{
                Image("RamaStand").resizable().scaledToFit()
                Text("Welcome \n to \n Wayangan")
                    .multilineTextAlignment(.center)
                    .padding(10)
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 2))
                    .onAppear {player.play()}
            }
        }
    }
}
