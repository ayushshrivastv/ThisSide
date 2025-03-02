//OnboardingPage
import SwiftUI

struct OnboardingView: View {
    @State private var currentPage = 0
    @State private var navigateToLanding = false
    private let totalPages = 3
    
    var body: some View {
        Group {
            if navigateToLanding {
                LandingPageView()
                    .transition(.opacity)
            } else {
                content
                    .transition(.asymmetric(
                        insertion: .opacity,
                        removal: .offset(x: -UIScreen.main.bounds.width)
                    ))
            }
        }
    }
    
    private var content: some View {
        ZStack {
            Color.black.ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                ForEach(0..<totalPages, id: \.self) { index in
                    OnboardingPage(
                        title: pageData[index].title,
                        description: pageData[index].description,
                        imageName: pageData[index].imageName,
                        index: index
                    )
                    .tag(index)
                }
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            
            VStack(spacing: 0) {
                Spacer()
                
                //page view
                HStack(spacing: 8) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        Capsule()
                            .fill(LinearGradient(
                                gradient: Gradient(colors: currentPage == index ? [.blue, .purple] : [.gray.opacity(0.3)]),
                                startPoint: .leading,
                                endPoint: .trailing))
                            .frame(width: currentPage == index ? 20 : 8, height: 8)
                            .animation(.spring(response: 0.4), value: currentPage)
                    }
                }
                .padding(.bottom, 40)
                
                //navigation Button
                if currentPage == totalPages - 1 {
                    Button(action: navigateToLandingPage) {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .background(
                                LinearGradient(gradient: Gradient(colors: [.blue, .purple]), startPoint: .leading, endPoint: .trailing)
                                    .cornerRadius(25)
                            )
                            .shadow(color: .blue.opacity(0.9), radius: 10, x: 0, y: 5)
                            .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                    .buttonStyle(ScaleButtonStyle())
                    .padding(.bottom, 40)
                }
            }
        }
    }
    //to go back to landingpage
    private func navigateToLandingPage() {
        withAnimation(.easeInOut(duration: 0.4)) {
            navigateToLanding = true
        }
    }
    //page data
    private var pageData: [(title: String, description: String, imageName: String)] {
        [
            ("ThisSide", "Track. Connect. Belong.", "Earth"),
            ("Family Circle", "Peace comes from knowing your loved ones are safe, no matter where they are.", "Space2"),
            ("Safety First", "One Safe Act Can Save a Life.", "Safe")
        ]
    }
}

struct ScaleButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.easeInOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct OnboardingPage: View {
    let title: String
    let description: String
    let imageName: String
    let index: Int
    
    @State private var animateAll = false
    @State private var animateImage = false
    
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            
            //title
            Text(title)
                .font(.system(size: 44, weight: .bold, design: .default))
                .foregroundColor(.white)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 40)
                .scaleEffect(animateAll ? 1 : 0.8)
                .opacity(animateAll ? 1 : 0)
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7), value: animateAll)
                .overlay(
                    LinearGradient(
                        colors: [.white.opacity(0.8), .white.opacity(0.2)],
                        startPoint: .top,
                        endPoint: .bottom
                    )
                    .mask(
                        Text(title)
                            .font(.system(size: 44, weight: .bold, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .scaleEffect(animateAll ? 1 : 0.8)
                            .opacity(animateAll ? 1 : 0)
                    )
                )
                .shadow(color: Color.yellow.opacity(0.8), radius: 10, x: 0, y: 0)
            
            //description
            Text(description)
                .font(.system(size: 22, weight: .medium, design: .default))
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
                        Text(description)
                            .font(.system(size: 22, weight: .medium, design: .default))
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 40)
                            .padding(.top, 20)
                            .lineSpacing(6)
                    )
                )
                .animation(.interactiveSpring(response: 0.6, dampingFraction: 0.7), value: animateAll)
            
            //image
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 300, height: 300)
                .padding(.top, 40)
                .shadow(color: Color.blue.opacity(0.4), radius: 20, x: 0, y: 10)
                .scaleEffect(animateImage ? 1 : 0.95)
                .opacity(animateImage ? 1 : 0)
                .animation(
                    .interactiveSpring(response: 0.6, dampingFraction: 0.7)
                    .delay(0.3),
                    value: animateImage
                )
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(
            ZStack {
                AngularGradient(colors: [.blue, .purple, .blue], center: .center)
                    .blur(radius: 50)
                    .opacity(0.3)
                LinearGradient(
                    colors: [.black.opacity(0.7), .black],
                    startPoint: .top,
                    endPoint: .bottom
                )
            }
                .ignoresSafeArea()
        )
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
    }
}
//preview
struct OnboardingView_Previews: PreviewProvider {
    static var previews: some View {
        OnboardingView()
    }
}
