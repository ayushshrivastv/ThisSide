//SpaceView.swift is the main file with SafeMode!
//for now we can bypass the login process.

import SwiftUI
import MapKit
import CoreLocation

//safemode featuring a distress button and helpful guides for first aid and self-defense, so you’re ready for any emergency..
struct SpaceView: View {
    let currentUser: Friend
    @State private var showPopup: Bool = true
    @State private var cameraPosition: MapCameraPosition = .region(
        MKCoordinateRegion(
            center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
        )
    )
    //states defined 
    @State private var isPresentingSOS: Bool = false
    @State private var friends: [Friend] = []
    @State private var searchText: String = ""
    @State private var isSignInActive: Bool = false
    @State private var isSafeModeActive: Bool = false
    @State private var showingHealthView: Bool = false
    @State private var showingVisionView: Bool = false
    
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass
    @Environment(\.verticalSizeClass) private var verticalSizeClass
    //body
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                //SpaceView
                VStack(spacing: 0) {
                    
                    HStack(spacing: 16) {
                        if isSignInActive {
                            Button(action: { isSignInActive = false }) {
                                Image(systemName: "chevron.left")
                                    .font(.system(size: 20, weight: .semibold))
                                    .foregroundColor(.white)
                                    .padding(8)
                            }
                        }
                        //image 
                        Image("WelcomeImage")
                            .resizable()
                            .scaledToFit()
                            .frame(height: 40)
                        
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
                    .padding(.top, geometry.safeAreaInsets.top + 10)
                    .padding(.bottom, 12)
                    .background(Color.black)
                    
                    //search bar to search friend on map..
                    TextField("Search Friend's Location", text: $searchText, onCommit: searchFriend)
                        .padding(.vertical, 12)
                        .padding(.horizontal, 20)
                        .background(Color.gray.opacity(0.2))
                        .cornerRadius(22)
                        .foregroundColor(Color.white)
                        .padding(.horizontal, 16)
                        .padding(.bottom, 12)
                    
                    //mapview
                    ZStack(alignment: .topLeading) {
                        MapView(
                            cameraPosition: $cameraPosition,
                            geometry: geometry,
                            friends: friends,
                            isPresentingSOS: $isPresentingSOS
                        )
                        .frame(height: geometry.size.height * 0.4)
                    }
                    
                    //safemode 
                    VStack(spacing: 0) {
                        HStack {
                            Text("Prevention is better than cure.")
                                .font(.system(size: 16))
                                .foregroundColor(Color.white)
                            
                            Spacer()
                            
                            Button(action: activateSafetyFeature) {
                                VStack {
                                    Image(systemName: "shield.lefthalf.filled")
                                        .font(.system(size: 20))
                                        .foregroundColor(.blue)
                                    Text("Safe Mode")
                                        .font(.system(size: 12))
                                        .foregroundColor(Color.white)
                                }
                            }
                        }
                        .padding(.horizontal, 20)
                        .padding(.vertical, 12)
                        
                        //friends View
                        FriendsListView(friends: friends)
                            .frame(maxHeight: .infinity)
                        
                        //NavigationBar Buttons
                        ActionButtonsView(
                            showingHealthView: $showingHealthView,
                            showingVisionView: $showingVisionView
                        )
                        .padding(.horizontal, 0.4)
                        .padding(.bottom, 0.4)
                    }
                    .background(Color.clear)
                }
                .background(Color.black)
                
                //popup 4
                if showPopup {
                    CustomPopup4(isVisible: $showPopup)
                        .zIndex(2)
                }
                
                //navigation bar Vision and Health View..
                if showingHealthView {
                    HealthView(
                        showingHealthView: $showingHealthView,
                        showingVisionView: $showingVisionView
                    )
                    .zIndex(3)
                    .transition(.identity)
                }
                
                //vision view
                if showingVisionView {
                    VisionView(
                        showingHealthView: $showingHealthView,
                        showingVisionView: $showingVisionView
                    )
                    .zIndex(3)
                    .transition(.identity)
                }
            }
            .background(Color.black)
            .edgesIgnoringSafeArea(.all)
        } 
        //top navigation bar is hidden due to duplication between ContentView and SpaceView..
        .navigationBarHidden(true)
        .sheet(isPresented: $isSafeModeActive) {
            SafeModeView(currentUser: currentUser)
        }
        .onAppear {
            fetchFriends()
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: currentUser.location,
                    span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                ))
        }
    }
    
    //safemode 
    private func activateSafetyFeature() {
        isSafeModeActive = true
    }
    
    //Fetch friends’ list uses random coordinates for the selected country and city.
    private func fetchFriends() {
        let userLocation = currentUser.location
        friends = [
            Friend(name: "Serena van der Woodsen", location: randomLocation(within: 5000, center: userLocation), color: .blue, phoneNumber: "1234567890"),
            Friend(name: "Blair Waldorf", location: randomLocation(within: 5000, center: userLocation), color: .pink, phoneNumber: "0987654321"),
            Friend(name: "Chuck Bass", location: randomLocation(within: 5000, center: userLocation), color: .purple, phoneNumber: "9876543210"),
            Friend(name: "Nate Archibald", location: randomLocation(within: 5000, center: userLocation), color: .green, phoneNumber: "1122334455"),
            Friend(name: "Dan Humphrey", location: randomLocation(within: 5000, center: userLocation), color: .yellow, phoneNumber: "6677889900")
        ]
        friends.insert(currentUser, at: 0)
    }
    
    //search friend
    func searchFriend() {
        if let friend = friends.first(where: { $0.name.lowercased().contains(searchText.lowercased()) }) {
            cameraPosition = .region(
                MKCoordinateRegion(
                    center: friend.location,
                    span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
                ))
            DispatchQueue.main.async {
                withAnimation {
                    showPopup = true
                }
            }
        }
    }
    
    //randomlocation, I wanted to show you the purpose of ThisSide. Right now, you need Backened to see it, but I’ll add it later..
    private func randomLocation(within radius: Double, center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let earthRadius = 6371000.0
        let maxDistance = radius / earthRadius
        let randomAngle = Double.random(in: 0..<2 * .pi)
        let randomDistance = sqrt(Double.random(in: 0..<1)) * maxDistance
        
        let newLat = center.latitude + (randomDistance * cos(randomAngle)) * (180 / .pi)
        let newLon = center.longitude + (randomDistance * sin(randomAngle)) * (180 / .pi) / cos(center.latitude * .pi / 180)
        
        return CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
    }
}
//location Coordinate logic
extension CLLocationCoordinate2D: @retroactive Hashable {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(latitude)
        hasher.combine(longitude)
    }
    
    public static func == (lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
    }
}
//safe mode features a distress button to alert nearby app users of your location and emergency. It also includes a first aid guide and self-defense tips.

struct SafeModeView: View {
    let currentUser: Friend
    @State private var unsafeLocations: [CLLocationCoordinate2D] = []
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    //body
    var body: some View {
        NavigationView {
            ScrollView { 
                VStack {
                    
                    HStack {
                        Spacer()
                        Button(action: {
                            dismiss()
                        }) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.title)
                                .foregroundColor(Color.red)
                                .padding()
                        }
                    }
                    
                    //Map position
                    Map(position: .constant(.region(MKCoordinateRegion(
                        center: currentUser.location,
                        span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
                    )))) {
                        Annotation("You", coordinate: currentUser.location) {
                            Image(systemName: "person.circle.fill")
                                .foregroundColor(.blue)
                                .font(.title)
                        }
                        //can display random unsafe location for demo
                        ForEach(unsafeLocations, id: \.self) { location in
                            Annotation("Unsafe", coordinate: location) {
                                Image(systemName: "exclamationmark.triangle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                            }
                        }
                    }
                    .frame(height: 400)
                    .cornerRadius(12)
                    .padding()
                    
                    //safetymessage
                    Text("If you feel unsafe, connect with nearby users for assistance.")
                        .font(.headline)
                        .multilineTextAlignment(.center)
                        .foregroundColor(Color(.label))
                        .padding()
                    
                    //distress button
                    Button(action: {
                        showAlert = true
                    }) {
                        HStack {
                            Image(systemName: "")
                            Text("In distress? Help from nearby users is just one tap away!")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.clear))
                        .foregroundColor(Color(.label))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(.label).opacity(0.7), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    .alert("Help Request Sent", isPresented: $showAlert) {
                        Button("OK", role: .cancel) { dismiss() }
                    } message: {
                        Text("Distress signal sent! Nearby users are aware of your situation.")
                    }
                    //emergency firstaid
                    NavigationLink(destination: ContentView().navigationBarHidden(true)) { 
                        HStack {
                            Text("Learn First Aid")
                            Image(systemName: "shield.fill")
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color(.clear))
                        .foregroundColor(Color(.label))
                        .overlay(
                            RoundedRectangle(cornerRadius: 25)
                                .stroke(Color(.label).opacity(0.7), lineWidth: 1)
                        )
                    }
                    .padding(.horizontal)
                    
                    //learn firstaid
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Survival Response: A Guide to Safety and Self-Defense in Dangerous Situations")
                            .font(.headline)
                            .padding(.horizontal)
                            .padding(.top)
                        
                        //self defense 
                        NavigationLink(destination: SuspiciousView()) {
                            HStack {
                                Image(systemName: "heart.fill")
                                    .foregroundColor(.red)
                                Text("Chapter 1: The First Senses")
                                    .foregroundColor(Color(.label))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                        
                        //emergencies
                        NavigationLink(destination: EmergencyGuideView()) {
                            HStack {
                                Image(systemName: "cross.case.fill")
                                    .foregroundColor(.blue)
                                Text("Chapter 2: What to Do If Attacked")
                                    .foregroundColor(Color(.label))
                                Spacer()
                                Image(systemName: "chevron.right")
                                    .foregroundColor(Color(.secondaryLabel))
                            }
                            .padding()
                            .background(Color(.secondarySystemBackground))
                            .cornerRadius(10)
                            .padding(.horizontal)
                        }
                    }
                    .padding(.vertical)
                    
                    Spacer()
                }
                .background(Color(.systemBackground))
                .onAppear {
                    unsafeLocations = (0..<5).map { _ in
                        randomLocation(within: 500, center: currentUser.location)
                    }
                }
            }
            .navigationTitle("Safe Mode")
            .navigationBarHidden(true) 
        }
        .navigationViewStyle(.stack) 
    }
    //randomlocation of demo friends and current user..
    private func randomLocation(within radius: Double, center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let earthRadius = 6371000.0
        let maxDistance = radius / earthRadius
        let randomAngle = Double.random(in: 0..<2 * .pi)
        let randomDistance = sqrt(Double.random(in: 0..<1)) * maxDistance
        
        let newLat = center.latitude + (randomDistance * cos(randomAngle)) * (180 / .pi)
        let newLon = center.longitude + (randomDistance * sin(randomAngle)) * (180 / .pi) / cos(center.latitude * .pi / 180)
        
        return CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
    }
}

//EmergencyView 
struct EmergencyView: View {
    var body: some View {
        ScrollView {
            VStack {
                Text("Emergency Assistance")
                    .font(.largeTitle)
                    .bold()
                    .padding()
                
                Text("Call emergency services or reach out to nearby users for immediate help.")
                    .font(.headline)
                    .multilineTextAlignment(.center)
                    .padding()
            }
        }
        .navigationTitle("Emergency")
    }
}

//selfdefenceGuide 
struct SuspiciousView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("The First Senses")
                    .font(.largeTitle)
                    .bold()
                
                VStack(alignment: .leading, spacing: 15) {
                    StepUpView(icon: "eyes", title: "Stay Calm", description: "The first instinct may be panic, but staying calm is essential. Take deep breaths to maintain clarity of thought.")
                    
                    StepUpView(icon: "eye.fill", title: "Assess the Threat", description: "The person should quickly evaluate if the individual is truly a threat. Are they following directly or just walking in the same direction? This helps in deciding the next course of action.")
                    
                    StepUpView(icon: "map.fill", title: "Change Direction", description: "If possible, change your route, cross to the opposite side of the street, or turn down a different street. This could help create distance and make it more difficult for the follower to predict your movements.")
                    
                    StepUpView(icon: "flame.fill", title: "Head Toward a Public Area", description: "Always try to head toward well-lit, populated areas, such as a busy store or restaurant, where other people are present. This increases your chances of getting help if needed.")
                    
                    StepUpView(icon: "eye.slash.fill", title: "Make Eye Contact", description: "If the person is too close or seems menacing, try making brief eye contact. Often, potential threats will back off when they feel observed. It also signals that you’re aware of their presence.")
                    
                    StepUpView(icon: "phone.fill", title: "Call for Help", description: "If the situation escalates, discreetly call the police or a trusted friend. If you can’t speak without drawing attention, send a text or use a silent alarm if available on your phone or smartwatch.")
                    
                    StepUpView(icon: "shield.fill", title: "Prepare to Defend Yourself", description: "In the worst-case scenario, where escape isn’t possible, prepare to defend yourself. Use available objects for defense (e.g., a purse, keys, or anything nearby), and make loud noises to attract attention.")
                    
                    StepUpView(icon: "paperplane.fill", title: "Keep Moving", description: "Avoid stopping or hesitating. Walking quickly toward safety is your best option. If necessary, run to the nearest place with people, such as a store or a well-lit area where help can be easily reached.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("The Will to Survive")
    }
}

struct EmergencyGuideView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("How to Defend Yourself and Survive")
                    .font(.largeTitle)
                    .bold()
                
                //common situations
                VStack(alignment: .leading, spacing: 15) {
                    EmergencyStepView(icon: "eye.fill", title: "Stay Calm and Assess the Threat", description: "Try to stay as calm as possible. Quickly assess the attacker’s intentions (e.g., is it physical assault, robbery, etc.). This assessment can guide your response and help you focus on surviving the situation.")
                    
                    EmergencyStepView(icon: "pencil.slash", title: "Fight for Escape", description: "The goal should always be to escape the situation if possible. Use any opportunity to break free from the attacker’s grip or distraction. If you’re pinned down, try to move or reposition yourself to make a quick escape.")
                    
                    EmergencyStepView(icon: "location.fill", title: "Shout for Help", description: "If there’s anyone nearby, shout loudly to attract attention and alert others that you’re in danger. This can either intimidate the attacker or prompt bystanders to intervene or call the authorities.")
                    
                    EmergencyStepView(icon: "flame.fill", title: "Use the Environment to Your Advantage", description: " If you’re near an exit, door, or window, try to make your way toward it. If you’re outside, look for a public place, a busy street, or a nearby store where you can get help.")
                    
                    EmergencyStepView(icon: "waveform.path.ecg", title: "Defend Yourself", description: " If you’re unable to escape and physical defense is necessary, protect vital areas such as your head, neck, and torso. Use anything at your disposal to defend yourself (e.g., your hands, feet, elbows, or nearby objects like keys, bags, or sticks). Aim for vulnerable points like the eyes, nose, throat, or groin, which can provide a moment of distraction.")
                    
                    EmergencyStepView(icon: "eye.slash.fill", title: "Protect Your Personal Belongings", description: "Clear the area around the person. Do not restrain them. Time the seizure and call for help if it lasts more than 5 minutes.")
                    
                    EmergencyStepView(icon: "shield.fill", title: "Remember the Attacker’s Details", description: "As soon as you’re safe, try to remember specific details about the attacker, such as their physical appearance, clothing, or any distinctive features. This information will be helpful for the authorities later.")
                    
                    EmergencyStepView(icon: "bandage.fill", title: "Seek Medical Help", description: "Once you’ve escaped and are in a safe place, seek medical attention immediately if you’ve been injured, even if the injuries seem minor. Documenting injuries is essential for legal or police purposes.")
                    
                    EmergencyStepView(icon: "phone.fill", title: "Report the Incident", description: "Contact local authorities and report the attack as soon as possible. The sooner they are informed, the higher the chances of catching the attacker and preventing future incidents.")
                    
                    EmergencyStepView(icon: "heart.fill", title: "Take Care of Your Mental Health", description: "Being attacked can leave emotional scars. After the event, it’s important to seek support, whether through friends, family, or a professional counselor, to process the trauma and find ways to heal.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("What to Do If Attacked")
    }
}

//pageview
struct StepUpView: View {
    var icon: String
    var title: String
    var description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            Image(systemName: icon)
                .font(.title)
                .frame(width: 30, height: 30)  // Adjust icon size
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .bold()
                Text(description)
                    .font(.body)
                    .foregroundColor(.gray)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
        }
        .padding(.vertical, 5)
    }
}

struct EmergencyStepView: View {
    let icon: String
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Image(systemName: icon)
                .font(.headline)
                .foregroundColor(.red)
                .frame(width: 30, alignment: .center)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
    }
}

//preview SpaceView.swift, is the homepage with a friend MapView, showing where your friends are in realtime, making it easy to stay connected!

struct SpaceView_Previews: PreviewProvider {
    static var previews: some View {
        SpaceView(
            currentUser: Friend(
                name: "Test User",
                location: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
                color: .red,
                phoneNumber: "1234567890"
            )
        )
        .preferredColorScheme(.dark) 
    }
}


//For now, I'm using random location coordinates. To add realtime data, I need to connect the app to the backend to fetch the data. I’ve tried this, but I still need to improve the code with algorithms and a view pattern to properly display the mapview. I’ll get to work on this in the future!


//few things are optimised to operate without the internet for SSC, even the user’s location.


//this side is tailored for the iPhone 16 Pro layout. Everything looks and feels great on that screen size.

//I’ve used the character name just to display mock data page, but I’ll change it later..

//The purpose of making this app is There are countless moments when you wish you could check in on a family member, know they’ve arrived safely at their destination. But, unfortunately, that’s not always as easy as it sounds. Communication can fall through the cracks, and busy lives can cause gaps in connection. That’s where ThisSide comes in.                                                                           I created ThisSide because I know what it’s like to feel that pang of worry when you can’t reach a loved one or the uncertainty when you don’t know where they are. I know the longing for reassurance that comes from just knowing they’re safe, or that they’re close, even if it’s just emotionally. That’s why this side exists to help you feel that peace. It’s not just about tracking; it’s about never feeling far apart from the ones you love, no matter where life leads you.
