//ThisSide- A Guiding star in a silent night, Distance fades when hearts align. A checkin turns worry to warmth divine, Life's Best moments, are shared in peace, bathed in light. Love is more than being near- It's proving you care, year by year. Through every mile, through night and day, Peace of mind won't drift away. In every call, in every sign, Love remains- a steady line.. 


import SwiftUI
//flashview
struct FlashView: View {
    @State private var currentPage = 0
    @State private var contentOpacity = 1.0
    @State private var animateAll = false
    @State private var navigateToLanding = false 
    private let totalPages = 8
    private let frameHeight: CGFloat = UIScreen.main.bounds.height * 0.65
    
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
            Color(UIColor.black)
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                if currentPage == 0 {
                    HeaderView(text: "ThisSide", fontSize: 44, gradientColors: [.white.opacity(0.8), .white.opacity(0.2)], shadowColor: .yellow)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .transition(.opacity)
                }
                
                if (1...6).contains(currentPage) {
                    HeaderView(text: pageMessages[currentPage - 1], fontSize: currentPage == 1 ? 36 : 28, gradientColors: [.white.opacity(0.8), .white.opacity(0.2)], shadowColor: .yellow)
                        .frame(maxWidth: .infinity, alignment: .topLeading)
                        .padding(.leading, 20)
                        .padding(.top, 40)
                        .transition(.opacity)
                }
                
                Spacer()
                
                TabView(selection: $currentPage) {
                    ForEach(0..<totalPages, id: \.self) { index in
                        CardView(
                            title: pageData[index].title,
                            subtitle: pageData[index].subtitle,
                            imageName: pageData[index].imageName
                        )
                        .tag(index)
                        .padding(.horizontal, 20)
                        .transition(.slide)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
                .frame(height: frameHeight)
                
                PageIndicators(totalPages: totalPages, currentPage: $currentPage)
                    .padding(.vertical, 20)
                
                ContinueButton(currentPage: $currentPage, totalPages: totalPages, navigateToLanding: $navigateToLanding)
                    .padding(.bottom, 30)
            }
            .opacity(contentOpacity)
        }
        .onAppear {
            animateAll = true
        }
    }
}

struct HeaderView: View {
    let text: String
    let fontSize: CGFloat
    let gradientColors: [Color]
    let shadowColor: Color
    
    var body: some View {
        Text(text)
            .font(.system(size: fontSize, weight: .bold, design: .default))
            .foregroundColor(.white)
            .multilineTextAlignment(.leading)
            .overlay(
                LinearGradient(
                    colors: gradientColors,
                    startPoint: .top,
                    endPoint: .bottom
                )
                .mask(
                    Text(text)
                        .font(.system(size: fontSize, weight: .bold, design: .default))
                )
            )
            .shadow(color: shadowColor.opacity(0.8), radius: 10, x: 0, y: 0)
    }
}

struct PageIndicators: View {
    let totalPages: Int
    @Binding var currentPage: Int
    
    var body: some View {
        HStack(spacing: 10) {
            ForEach(0..<totalPages, id: \.self) { index in
                Capsule()
                    .fill(index == currentPage ? Color.gray : Color.gray.opacity(0.3))
                    .frame(width: index == currentPage ? 20 : 8, height: 8)
                    .scaleEffect(index == currentPage ? 1.2 : 1.0)
                    .animation(.spring(response: 0.4), value: currentPage)
            }
        }
        .padding(.bottom, 20)
    }
}

struct ContinueButton: View {
    @Binding var currentPage: Int
    let totalPages: Int
    @Binding var navigateToLanding: Bool //binding for navigation
    
    var body: some View {
        Group {
            if currentPage == totalPages - 1 {
                Button(action: {
                    withAnimation {
                        navigateToLanding = true
                    }
                }) {
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
                .onTapGesture {
                    let generator = UIImpactFeedbackGenerator(style: .medium)
                    generator.impactOccurred()
                }
            }
        }
    }
}

struct CardView: View {
    let title: String
    let subtitle: String
    let imageName: String
    
    var body: some View {
        ZStack(alignment: .bottom) {
            //background Image
            GeometryReader { geometry in
                Image(imageName)
                    .resizable()
                    .scaledToFill()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                    .clipped()
                    .cornerRadius(25)
                    .shadow(radius: 8)
            }
            .edgesIgnoringSafeArea(.all)
            
            
            LinearGradient(
                gradient: Gradient(colors: [.clear, .black.opacity(0.8)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .cornerRadius(25)
            
            
            VStack(alignment: .leading, spacing: 12) {
                Text(title)
                    .font(.system(size: 34, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .multilineTextAlignment(.leading)
                    .shadow(color: .black.opacity(0.3), radius: 3, x: 0, y: 2)
                
                Text(subtitle.uppercased())
                    .font(.system(size: 20, weight: .semibold, design: .default))
                    .foregroundColor(.white.opacity(0.9))
                    .kerning(1.2)
                    .multilineTextAlignment(.leading)
                    .lineSpacing(8)
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 60)
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .frame(height: 540)
        .cornerRadius(25)
    }
}

extension FlashView {
    private var pageData: [(title: String, subtitle: String, imageName: String)] {
        [
            ("A Gentle Reminder They’re Safe", "Feel the warmth of knowing your loved ones are okay, even when miles apart.", "Ship"),
            ("Wherever They Go, You’ll Know", "Follow their journey with a quiet whisper of reassurance, not a storm of worry.", "image2"),
            ("One Tap, Infinite Peace", "A single touch bridges the distance, bringing comfort to your heart.", "image3"),
            ("Love Has No Distance", "Feel their presence, even when life takes them far away.", "image4"),
            ("The Quiet Joy of Connection", "No words needed—just the silent comfort of knowing they’re close.", "image5"),
            ("Your Circle, Always Within Reach", "See their world light up on your screen, a heartbeat away.", "image6"),
            ("Safety Wrapped in Love", "Wrap your loved ones in a blanket of care, no matter where they roam.", "image7"),
            ("Together, Even When Apart", "Because love isn’t about proximity—it’s about connection.", "image8")
        ]
    }
    
    private var pageMessages: [String] {
        [
            "A guiding star in a silent night.",
            "Distance fades when hearts align, A check-in turns worry to warmth divine.",
            "Life’s best moments, pure and bright, Are shared in peace, bathed in light.",
            "Love is more than being near— It’s proving you care, year by year.",
            "Through every mile, through night and day, Peace of mind won’t drift away.",
            "In every call, in every sign, Love remains—a steady line."
        ]
    }
}
//flashviewPreviews
struct FlashView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            FlashView()
                .preferredColorScheme(.dark)
        }
    }
}
