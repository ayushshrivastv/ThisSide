//LandingPage
import SwiftUI

struct LandingPageView: View {
    @State private var isUserSignedIn = false 
    @State private var showMessage = false 
    @State private var showBanner = false 
    
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 32) { 
                if showBanner {
                    HStack(alignment: .top) {
                        Text("ThisSide! – Because knowing where your loved ones are makes the distance feel shorter.")
                            .font(.subheadline)
                            .foregroundColor(.white.opacity(0.9))
                            .lineSpacing(4)
                        
                        Spacer()
                        
                        Button {
                            withAnimation(.smooth) {
                                showBanner = false
                            }
                        } label: {
                            Image(systemName: "xmark.circle.fill")
                                .symbolRenderingMode(.hierarchical)
                                .foregroundColor(.white)
                                .font(.system(size: 22))
                        }
                    }
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                            .fill(.ultraThinMaterial)
                            .shadow(color: .black.opacity(0.2), radius: 8, x: 0, y: 4)
                    )
                    .padding(.horizontal, 20)
                    .transition(.opacity.combined(with: .scale(scale:0.95)))
                }
                
                //image
                Spacer()
                Image("WelcomeImage") 
                    .resizable()
                    .scaledToFit()
                    .frame(width: 300, height: 250)
                    .cornerRadius(20)
                    .shadow(color: Color.blue.opacity(10), radius: 40, x: 0, y: 0.8)
                    .scaleEffect(animateImage ? 1 : 0.95)
                    .opacity(animateImage ? 1 : 0)
                    .animation(
                        .interactiveSpring(response: 0.6, dampingFraction: 0.7)
                        .delay(0.3),
                        value: animateImage
                    )
                
                //headline
                Text("Where Exploration Meets Connection Start Your Journey with ThisSide!")
                    .font(.system(size: 24, weight: .medium, design: .default))
                    .foregroundColor(.white.opacity(0.7))
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.top, 20)
                    .lineSpacing(6)
                    .fixedSize(horizontal: false, vertical: true)
                    .scaleEffect(animateAll ? 1 : 0.8)
                    .opacity(animateAll ? 1 : 0)
                    .overlay(
                        LinearGradient(
                            colors: [.white.opacity(0.8), .white.opacity(0.2)],
                            startPoint: .top,
                            endPoint: .bottom
                        )
                        .mask(
                            Text("Where Exploration Meets Connection Start Your Journey with ThisSide!")
                                .font(.system(size: 24, weight: .medium, design: .default))
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 40)
                                .padding(.top, 20)
                                .lineSpacing(6)
                        )
                    )
                    .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7), value: animateAll)
                
                Spacer()
                
                //buttons
                VStack(spacing: 15) {
                    if showMessage {
                        Text("You are now signed in!")
                            .padding()
                            .foregroundColor(.green)
                            .font(.headline)
                            .transition(.opacity)
                    }
                    
                    NavigationLink(destination: LoginView()) {
                        Text("Sign In")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear)
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 30)
                    
                    Button(action: {
                        print("Guiding Star. taped")
                        showMessage = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                            isUserSignedIn = true
                        }
                    }) {
                        Text("Guiding Star")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.clear.opacity(0.3))
                            .foregroundColor(.white)
                            .font(.system(size: 18, weight: .semibold))
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                            .shadow(radius: 3)
                    }
                    .padding(.horizontal, 30)
                }
                Spacer()
            }
            .padding(.horizontal, 16)
            .padding(.top, 20)
            .background(
                ZStack {
                    AngularGradient(colors: [.blue, .blue, .blue], center: .center)
                        .blur(radius: 50)
                        .opacity(0.8)
                    LinearGradient(
                        colors: [.black.opacity(0.7), .black],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                }
                    .ignoresSafeArea()
            )
            .animation(.easeInOut, value: showBanner) 
            .onAppear {
                withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7)) {
                    animateAll = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    withAnimation(.interactiveSpring(response: 0.6, dampingFraction: 0.7)) {
                        animateImage = true
                    }
                }
            }
            .onDisappear {
                animateAll = false
                animateImage = false
            }
            .fullScreenCover(isPresented: $isUserSignedIn) {
                FlashView()
            }
        }
    }
}
//preview
struct LandingPageView_Previews: PreviewProvider {
    static var previews: some View {
        LandingPageView()
            .preferredColorScheme(.dark)
    }
}
