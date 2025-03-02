//VisionView contains quizzes related to medical and safety situations to prepare users to act in emergencies..

import SwiftUI
//VisionView
struct VisionView: View {
    @Binding var showingHealthView: Bool
    @Binding var showingVisionView: Bool
    @State private var showLearnView = false
    
    var body: some View {
        ZStack {
            //background
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                //title
                HStack {
                    Text("Be Curious")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                    
                    Spacer()
                    //avatar
                    Image("Avatar") 
                        .resizable()
                        .scaledToFill()
                        .frame(width: 40, height: 40)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 1))
                }
                .padding(.horizontal, 16)
                .padding(.top, 16) 
                
                //interface
                Text("take the risk!")
                    .font(.system(size: 48, weight: .bold, design: .serif)) 
                    .foregroundColor(Color(hex: "#F5E6C5")) 
                    .textCase(.lowercase) 
                    .multilineTextAlignment(.center)
                    .padding(.top, 40) 
                
                Spacer()
                
                //animation view
                AnimationView()
                    .frame(height: 200) 
                
                Spacer()
                
                //interface design 
                VStack(alignment: .leading, spacing: 16) {
                    Text("Fuel Your Curiosity")
                        .font(.system(size: 38, weight: .bold))
                        .foregroundColor(.white)
                        .multilineTextAlignment(.leading)
                        .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                    
                    Text("Discover, Learn, and Expand Your Horizons".uppercased())
                        .font(.system(size: 16, weight: .semibold))
                        .foregroundColor(.white.opacity(0.9))
                        .kerning(1.2)
                        .multilineTextAlignment(.leading)
                        .lineSpacing(8)
                    
                    //navigation button
                    Button(action: {
                        showLearnView = true
                    }) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]),
                                               startPoint: .leading,
                                               endPoint: .trailing)
                                .cornerRadius(25)
                            )
                            .shadow(color: .blue.opacity(0.9), radius: 10, x: 0, y: 5)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    .buttonStyle(ScaleButtonStyle()) 
                    .padding(.bottom, 40)
                }
                .padding(.horizontal, 18)
                
                //navigationbar button 
                ActionButtonsView(
                    showingHealthView: $showingHealthView,
                    showingVisionView: $showingVisionView
                )
                .padding(.horizontal, 0.4)
                .padding(.bottom, 0.4)
            }
            .padding(.top, UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.windows.filter { $0.isKeyWindow }.first?.safeAreaInsets.top }
                .first ?? 0)
        }
        .navigationTitle("Vision")
        .navigationBarHidden(true)
        .sheet(isPresented: $showLearnView) {
            LearnView()
        }
    }
}

//animationview
struct AnimationView: View {
    @State private var xOffset: CGFloat = -100
    
    var body: some View {
        GeometryReader { geo in
            Image("Image 8") 
                .resizable()
                .scaledToFit()
                .frame(width: 400, height: 300)
                .position(x: xOffset, y: geo.size.height * 0.2)
                .onAppear {
    //the image moving across the screen continuously.
                    withAnimation(
                        Animation.linear(duration: 5)
                            .repeatForever(autoreverses: false)
                    ) {
                        xOffset = geo.size.width + 100
                    }
                }
        }
        //to move offscreen without affecting layout.
        .allowsHitTesting(false)
    }
}

//LearnView contains files from the ‘Situation’ folder..
struct LearnView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                //background Color
                Color.clear
                    .edgesIgnoringSafeArea(.all)
                
                VStack(alignment: .leading, spacing: 16) {

                    Text("take the risk!  ")
                        .font(.system(size: 42, weight: .bold, design: .default))
                        .foregroundColor(.yellow)
                        .multilineTextAlignment(.leading)
                        .padding(.leading, 20)
                    
                    //buttons
                    VStack(spacing: 20) {
                        NavigationLink {
                            SafetyView()
                        } label: {
                            HStack {
                                Image(systemName: "shield.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Safety")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Learn about safety protocols and tips.")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.black) 
                            .cornerRadius(15)
                            .shadow(color: .blue.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                        
                        NavigationLink {
                            MedicalView() 
                        } label: {
                            HStack {
                                Image(systemName: "cross.fill")
                                    .foregroundColor(.white)
                                    .frame(width: 30, height: 30)
                                
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Medical")
                                        .font(.headline)
                                        .foregroundColor(.white)
                                    Text("Explore medical information and resources.")
                                        .font(.subheadline)
                                        .foregroundColor(.white.opacity(0.8))
                                }
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(.white)
                            }
                            .padding()
                            .background(Color.black) 
                            .cornerRadius(15)
                            .shadow(color: .purple.opacity(0.3), radius: 10, x: 0, y: 5)
                        }
                    }
                    .padding(.horizontal)
                    
                    Spacer()
                    
                    //guideline
                    Text("Explore more to stay informed and prepared.")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
            }
            .navigationTitle("Prepare before the moment prepares you.")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}

//for fun, I’ve experimented with different colors instead of white. 

extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: 
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: 
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: 
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
//preview
struct VisionView_Previews: PreviewProvider {
    static var previews: some View {
        VisionView(showingHealthView: .constant(false), showingVisionView: .constant(false))
    }
}



//VisionView wants to help people see problems and deal with them well. When things go wrong, we often freeze or panic. But if we stay calm and think clearly, we can find solutions that might save lives or make good choices. 

//We can make it more exciting and offer something for kids aged 6 to 12 who are learning and growing fast. We can use physical toys or create fun digital games that they have a choice to pick from. Giving them points and explaining the situation can help build a better society. As we’ve seen, people often get scared when they help someone, unsure of what to do in that situation..
