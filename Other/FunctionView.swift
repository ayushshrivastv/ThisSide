//SpaceView Expand
import SwiftUI
import MapKit
import UserNotifications
import CoreLocation

struct MapView: View {
    
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            Map(position: $cameraPosition) {
                ForEach(friends) { friend in
                    Annotation(friend.name, coordinate: friend.location) {
                        Circle()
                            .fill(friend.color)
                            .frame(width: 10, height: 10)
                    }
                }
            }
            .cornerRadius(12)
            .padding(.horizontal, 10)
            
            Button(action: {
                isPresentingSOS = true
            }) {
                Text("HELP")
                    .font(.system(size: 14, weight: .bold, design: .rounded))
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.red)
                    .cornerRadius(10)
                    .padding(.trailing, 20)
                    .padding(.top, 10)
                    .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 2)
            }
            .sheet(isPresented: $isPresentingSOS) {
                SOSView(friends: friends)
            }
        }
    }
}

//SOSView
struct SOSView: View {
    let friends: [Friend]
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("Send SOS Message")
                .font(.title)
                .padding()
            
            Text("Your friends will receive a message with your current location.")
                .multilineTextAlignment(.center)
                .padding(.horizontal)
            
            Spacer()
            
            HStack {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Cancel")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    sendSOSMessage()
                }) {
                    Text("Send SOS")
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            
            Spacer()
        }
        .padding()
        .onAppear {
            requestNotificationPermissions()
        }
    }
    
    func sendSOSMessage() {
        sendNotification()
    }
    
    func sendNotification() {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "SOS Message Sent"
        notificationContent.body = "Your emergency message has been sent to friends."
        notificationContent.sound = .defaultCritical
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: notificationContent, trigger: nil)
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Error sending notification: \(error.localizedDescription)")
            } else {
                print("SOS notification successfully sent.")
            }
        }
    }
    
    func requestNotificationPermissions() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification permission error: \(error.localizedDescription)")
            } else if granted {
                print("Notification permission granted.")
            } else {
                print("Notification permission denied.")
            }
        }
    }
}

struct FriendsListView: View {
    let friends: [Friend]
    var onFriendTap: ((CLLocationCoordinate2D) -> Void)?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 15) {
                Text("Friends")
                    .font(.system(size: 20, weight: .bold, design: .default))
                    .foregroundColor(.white)
                    .padding(.leading, 20)
                    .padding(.top, 10)
                
                ForEach(friends) { friend in
                    HStack {
                        Circle()
                            .fill(friend.color)
                            .frame(width: 20, height: 20)
                        
                        Text(friend.name)
                            .font(.system(size: 16, weight: .regular, design: .default))
                            .foregroundColor(.white)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white.opacity(0.1))
                    .cornerRadius(10)
                    .padding(.horizontal, 20)
                    .onTapGesture {
                        onFriendTap?(friend.location) 
                    }
                }
            }
            .padding(.vertical, 10)
        }
    }
}

//navigation bar action button view is implemented in functionview and will use it in Space, Heart, Vision struct...

struct ActionButtonsView: View {
    @Binding var showingHealthView: Bool
    @Binding var showingVisionView: Bool
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 25, style: .continuous)
                .fill(Material.ultraThinMaterial)
                .overlay(
                    RoundedRectangle(cornerRadius: 25)
                        .stroke(Color.white.opacity(0.1), lineWidth: 0.5)
                )
                .shadow(color: .black.opacity(0.3), radius: 10, x: 0, y: 5)
                .colorScheme(.dark)
            
            HStack(spacing: 0) {
                NavigationBarButton(
                    title: "Health",
                    icon: "heart",
                    isActive: showingHealthView,
                    action: {
                        showingVisionView = false
                        showingHealthView = true
                    }
                )
                
                Spacer(minLength: 20)
                
                NavigationBarButton(
                    title: "Space",
                    icon: "location",
                    isActive: !showingHealthView && !showingVisionView,
                    action: {
                        showingHealthView = false
                        showingVisionView = false
                    }
                )
                
                Spacer(minLength: 20)
                
                NavigationBarButton(
                    title: "Vision",
                    icon: "eye",
                    isActive: showingVisionView,
                    action: {
                        showingHealthView = false
                        showingVisionView = true
                    }
                )
            }
            .padding(.horizontal, 24)
            .frame(height: 60)
        }
        .frame(height: 60)
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

//navigationBarButton
struct NavigationBarButton: View {
    let title: String
    let icon: String
    let isActive: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    private var textColor: Color {
        isActive ? .white : .white.opacity(0.7)
    }
    
    private var iconColor: Color {
        isActive ? .red : .white.opacity(0.7)
    }
    
    private var iconWeight: Font.Weight {
        isActive ? .semibold : .medium
    }
    
    var body: some View {
        Button(action: action) {
            VStack(spacing: 4) {
                Image(systemName: icon + (isActive ? ".fill" : ""))
                    .symbolRenderingMode(.monochrome)
                    .font(.system(size: 22, weight: iconWeight))
                    .foregroundColor(iconColor)
                    .frame(width: 28, height: 28)
                
                Text(title)
                    .font(.system(size: 12, weight: isActive ? .semibold : .medium))
                    .foregroundColor(textColor)
            }
            .frame(maxWidth: .infinity)
            .contentShape(Rectangle())
            .scaleEffect(isPressed ? 0.92 : 1)
            .animation(.interactiveSpring(response: 0.3, dampingFraction: 0.6), value: isPressed)
        }
        .buttonStyle(.plain)
        .pressActions(
            onPress: { isPressed = true },
            onRelease: { isPressed = false }
        )
    }
}

//pressActions Modifier
struct PressActions: ViewModifier {
    var onPress: () -> Void
    var onRelease: () -> Void
    
    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged({ _ in
                        onPress()
                    })
                    .onEnded({ _ in
                        onRelease()
                    })
            )
    }
}

extension View {
    func pressActions(onPress: @escaping (() -> Void), onRelease: @escaping (() -> Void)) -> some View {
        modifier(PressActions(onPress: {
            onPress()
        }, onRelease: {
            onRelease()
        }))
    }
}
//friend struct
struct Friend: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
    let color: Color
    let phoneNumber: String
}
