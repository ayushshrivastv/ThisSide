//I intended to use HealthKit to display data from the iphone in my app without collecting any new data. However, I need the Xcode implementation for full integration..

import SwiftUI
//healthview

struct HealthView: View {
    @Binding var showingHealthView: Bool
    @Binding var showingVisionView: Bool
    
    private var todayDate: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter.string(from: Date())
    }
    
    //sample data for family members
    let familyMembers = [
        FamilyMember(name: "Blair Waldorf", heartRate: "72 BPM", sleep: "7h 12m", steps: "8,342 Steps", avatar: "Avatar2"),
        FamilyMember(name: "Nate Archibald", heartRate: "68 BPM", sleep: "6h 45m", steps: "7,890 Steps", avatar: "Avatar3"),
        FamilyMember(name: "Chuck Bass", heartRate: "75 BPM", sleep: "8h 00m", steps: "9,123 Steps", avatar: "Avatar4")
    ]
    
    var body: some View {
        ZStack {
        
            Color.black
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                
                HStack(alignment: .top) {
                    
                    VStack(alignment: .leading) {
                        Text("Today")
                            .font(.largeTitle.weight(.bold))
                            .foregroundColor(.white)
                        Text(todayDate)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer() 
                    
                    HStack(spacing: 16) {
                      
                        Button(action: {
                    
                            print("Plus button tapped")
                        }) {
                            Image(systemName: "plus")
                                .font(.title2.weight(.bold))
                                .foregroundColor(.white)
                                .padding(8)
                                .background(Color.gray.opacity(0.3))
                                .clipShape(Circle())
                        }
                        
                        //avatar
                        Image("Avatar") 
                            .resizable()
                            .scaledToFill()
                            .frame(width: 40, height: 40)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 1))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 20)
                
                //scrollable content (CardView, Health Metrics, and Heart Rate Graph)
                ScrollView {
                    VStack(spacing: 16) {
                        HealthCardView(
                            title: "Welcome Back!",
                            subtitle: "The greatest wealth is not found in banks but in the strength of your body and mind.",
                            imageName: "Image" 
                        )
                        .frame(height: UIScreen.main.bounds.height * 0.3) 
                        .padding(.horizontal, 20)
                        .padding(.top, 10) 
                        
                        //family update section
                        VStack(alignment: .leading, spacing: 16) {
                            Text("Family Update")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.horizontal, 20)
                            
                            ForEach(familyMembers, id: \.name) { member in
                                FamilyMemberView(member: member)
                                    .padding(.horizontal, 20)
                            }
                        }
                        
                        //health metrics
                        HealthMetricView(iconName: "heart.fill", title: "Heart Rate", value: "72 BPM")
                        HealthMetricView(iconName: "figure.walk", title: "Steps Count", value: "8,342 Steps")
                        HealthMetricView(iconName: "moon.fill", title: "Sleep", value: "7h 12m")
                        
                        //heart rate 
                        HeartRateGraphView()
                            .padding(.horizontal, 20)
                    }
                    .padding(.bottom, 20) 
                }
                
                //action buttons for navigationbar
                ActionButtonsView(
                    showingHealthView: $showingHealthView,
                    showingVisionView: $showingVisionView
                )
                .padding(.horizontal, 0.4)
                .padding(.bottom, 0.4)
            }
            .padding(.top, UIApplication.shared.connectedScenes
                .compactMap { ($0 as? UIWindowScene)?.windows.first(where: { $0.isKeyWindow })?.safeAreaInsets.top }
                .first ?? 0)
        }
        .navigationTitle("Health")
        .navigationBarHidden(true)
    }
}
//family member view
struct FamilyMemberView: View {
    var member: FamilyMember
    
    var body: some View {
        HStack {
            
            Image(member.avatar)
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .clipShape(Circle())
                .overlay(Circle().stroke(Color.white, lineWidth: 1))
            
            VStack(alignment: .leading) {
                Text(member.name)
                    .font(.headline)
                    .foregroundColor(.white)
                HStack {
                    Text("Heart: \(member.heartRate)")
                    Text("Sleep: \(member.sleep)")
                    Text("Steps: \(member.steps)")
                }
                .font(.subheadline)
                .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

//family Member Model
struct FamilyMember {
    var name: String
    var heartRate: String
    var sleep: String
    var steps: String
    var avatar: String 
}

//heart Rate Graph View
struct HeartRateGraphView: View {
    // Generate random heart rate data
    private var heartRateData: [Double] {
        (0..<24).map { _ in Double.random(in: 60...100) }
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            //title
            Text("Heart Rate Graph")
                .font(.headline)
                .foregroundColor(.white)
            
            //graph
            LineGraph(data: heartRateData)
                .frame(height: 150)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            HStack {
                Text("Last 24 Hours")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                
                Spacer()
                
                Button(action: {
                    
                    print("Time panel button tapped")
                }) {
                    Text("View All")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
            }
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

//line Graph View
struct LineGraph: View {
    var data: [Double]
    
    private var maxValue: Double {
        data.max() ?? 1
    }
    
    private var minValue: Double {
        data.min() ?? 0
    }
    
    var body: some View {
        GeometryReader { geometry in
            Path { path in
                for (index, value) in data.enumerated() {
                    let xPosition = geometry.size.width / CGFloat(data.count - 1) * CGFloat(index)
                    let yPosition = geometry.size.height - (CGFloat(value - minValue) / CGFloat(maxValue - minValue)) * geometry.size.height
                    
                    if index == 0 {
                        path.move(to: CGPoint(x: xPosition, y: yPosition))
                    } else {
                        path.addLine(to: CGPoint(x: xPosition, y: yPosition))
                    }
                }
            }
            .stroke(Color.red, style: StrokeStyle(lineWidth: 2, lineCap: .round, lineJoin: .round))
        }
    }
}

//health Metric View
struct HealthMetricView: View {
    var iconName: String
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Image(systemName: iconName)
                .font(.title2)
                .foregroundColor(.white)
                .frame(width: 40, height: 40)
                .background(Color.blue.opacity(0.3))
                .clipShape(Circle())
            
            VStack(alignment: .leading) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                Text(value)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
    }
}

//Health Card View 
struct HealthCardView: View {
    var title: String
    var subtitle: String
    var imageName: String
    
    var body: some View {
        ZStack(alignment: .leading) {
            //background image
            Image(imageName)
                .resizable()
                .scaledToFill()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .clipped()
                .cornerRadius(10)
            Color.black.opacity(0.4)
                .cornerRadius(10)

            VStack(alignment: .leading, spacing: 8) {
                Text(title)
                    .font(.title.weight(.bold))
                    .foregroundColor(.white)
                Text(subtitle)
                    .font(.subheadline)
                    .foregroundColor(.white.opacity(0.8))
            }
            .padding()
        }
        .frame(height: UIScreen.main.bounds.height * 0.3) 
        .cornerRadius(10)
    }
}
