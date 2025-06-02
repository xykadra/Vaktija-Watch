import SwiftUI
import WatchKit

struct VakatView: View {
    @EnvironmentObject var viewModel: VakatViewModel
    @EnvironmentObject var settings: SettingsManager
    @State private var scale: CGFloat = 1.0
    private let prayerNames = ["Zora", "Izlazak Sunca", "Podne", "Ikindija", "Aksam", "Jacija"]
    
    var body: some View {
        NavigationView {
            ScrollViewReader { proxy in
                VStack() {
                    
                    if let vakat = viewModel.vakatTime {
                        
                        Form {
                            Section("Danas"){
                                VStack(spacing: 4) {
                                    Text(vakat.hijriDate)
                                    Text(vakat.gregorianDate)
                                        .foregroundColor(.gray)
                                }
                            }
                            
                            ForEach(vakat.vakats.indices, id: \.self) { index in
                                let isCurrent = index == viewModel.currentVakatIndex(vakats: vakat.vakats)
                                
                                Section{
                                    // Horizontal Stack for Name and Time
                                    
                                    HStack{
                                        VStack (alignment: .leading){
                                            HStack {
                                                if isCurrent {
                                                    Circle()
                                                        .fill(Color.green)
                                                        .frame(width: 8, height: 8)
                                                        .scaleEffect(scale)
                                                        .onAppear {
                                                            withAnimation(Animation.easeInOut(duration: 1.2).repeatForever(autoreverses: true)) {
                                                                scale = 1.4
                                                            }
                                                        }
                                                }
                                                Text(prayerNames[index])
                                                    .fontWeight(.semibold)
                                            }
                                            
                                            if let timeLeft = viewModel.timeRemaining(for: vakat.vakats[index]) {
                                                Text(timeLeft)
                                                    .font(.footnote)
                                                    .foregroundColor(.gray)
                                            }
                                        }
                                        Spacer()
                                        Text(vakat.vakats[index])
                                            .fontWeight(.semibold)
                                    }
                                    
                                    
                                    
                                }
                                .id(index)
                            }
                            NavigationLink(destination: QiblaView()){
                                Label(
                                    "Kaaba Lokator", systemImage: "location"
                                ).frame(maxWidth: .infinity).multilineTextAlignment(.center).padding(.vertical, 8).foregroundColor(.green)
                            }
                            NavigationLink(destination: EditView()){
                                Label(
                                    "Uredi", systemImage: "pencil"
                                ).frame(maxWidth: .infinity).multilineTextAlignment(.center).padding(.vertical, 8).foregroundColor(.blue)
                            }
                            
                            
                        }.listSectionSpacing(8)
                            .onAppear {
                                if let currentIndex = viewModel.currentVakatIndex(vakats: vakat.vakats) {
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        proxy.scrollTo(currentIndex, anchor: .top)
                                        
                                        WKInterfaceDevice.current().play(.directionUp)
                                    }
                                }
                            }
                        
                        
                        
                        
                    } else {
                        ProgressView()
                    }
                }
            }
            .navigationTitle(settings.selectedCityName)
        }
        .onAppear {
            viewModel.loadVakat(for: settings.selectedCityIndex)
        }
        .onChange(of: settings.selectedCityIndex) { oldIndex, newIndex in
            viewModel.loadVakat(for: newIndex)
            
        }
    }
}
