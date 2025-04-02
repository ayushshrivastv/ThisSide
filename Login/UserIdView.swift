//UserIdView Family Circle

import SwiftUI
import CoreLocation
import UIKit

//location Manager

    
    override init() {
        authorizationStatus = locationManager.authorizationStatus
        super.init()
        locationManager.delegate = self
    }
    func requestPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        authorizationStatus = manager.authorizationStatus
    }
}

struct UserIdView: View {
    var groupCode: String
    var currentUser: Friend
    @State private var friends: [Friend] = []
    @State private var navigateToSpaceView = false
    @StateObject private var locationManager = LocationManager()
    @State private var showPermissionDeniedAlert = false
    
    //demo list for group code NY8282
    private var allFriendGroups: [Friend] {
        let userLocation = currentUser.location
        return [
            Friend(name: "Serena van der Woodsen", location: randomLocation(within: 10000, center: userLocation), color: .blue, phoneNumber: "1234567890"),
            Friend(name: "Blair Waldorf", location: randomLocation(within: 10000, center: userLocation), color: .pink, phoneNumber: "0987654321"),
            Friend(name: "Chuck Bass", location: randomLocation(within: 10000, center: userLocation), color: .purple, phoneNumber: "9876543210"),
            Friend(name: "Nate Archibald", location: randomLocation(within: 10000, center: userLocation), color: .green, phoneNumber: "1122334455"),
            Friend(name: "Dan Humphrey", location: randomLocation(within: 10000, center: userLocation), color: .yellow, phoneNumber: "6677889900")
        ]
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
    
                Color.black
                    .ignoresSafeArea()
                
                VStack(spacing: 20) {
               
                    VStack(spacing: 8) {
                        Text("Family Circle")
                            .font(.system(size: 28, weight: .bold))
                            .foregroundColor(.white.opacity(0.9))
                        
                        Text("Group Code: \(groupCode)")
                            .font(.system(size: 16, weight: .regular))
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 40)
       
                    if groupCode != "NY8282" {
                        Text("No friends have joined yet, but the adventure starts when they do.")
                            .font(.system(size: 20))
                            .foregroundColor(.gray)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal, 30)
                            .frame(maxHeight: .infinity)
                    } else {
                        if friends.isEmpty {
                            Text("No friends have joined this group yet.")
                                .font(.system(size: 14))
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(.horizontal, 30)
                                .frame(maxHeight: .infinity)
                        } else {
                            ScrollView {
                                VStack(spacing: 15) {
                                    ForEach(friends, id: \.id) { friend in
                                        HStack(spacing: 15) {
                                            Circle()
                                                .fill(friend.color)
                                                .frame(width: 50, height: 50)
                                            
                                            VStack(alignment: .leading, spacing: 5) {
                                                Text(friend.name)
                                                    .font(.system(size: 18, weight: .regular))
                                                    .foregroundColor(.white.opacity(0.9))
                                                
                                                Text("Lat: \(friend.location.latitude), Lon: \(friend.location.longitude)")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                                
                                                Text("Phone: \(friend.phoneNumber)")
                                                    .font(.system(size: 14))
                                                    .foregroundColor(.gray)
                                            }
                                            
                                            Spacer()
                                        }
                                        .padding()
                                        .background(
                                            RoundedRectangle(cornerRadius: 15)
                                                .fill(Color.gray.opacity(0.2))
                                        )
                                    }
                                }
                                .padding(.horizontal, 20)
                            }
                        }
                    }
                    
                    Spacer()
           
                    if groupCode == "NY8282" {
                        Button(action: {
                            navigateToSpaceView = true
                        }) {
                            Text("Continue")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                )
                                .shadow(radius: 5)
                        }
                        .padding(.horizontal, 30)
                        .padding(.bottom, 10)
                    }
                    
                    Button(action: {
                        shareGroupCodeViaMessage()
                    }) {
                        Text("Share Group Code")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .background(Color.clear)
                            .shadow(radius: 5)
                    }
                    .padding(.horizontal, 30)
                    .padding(.bottom, 20)
                }
            }
            .onAppear {
                checkLocationAuthorization()
                fetchFriends()
            }
            .onReceive(locationManager.$authorizationStatus) { status in
                handleAuthorizationStatus(status)
            }
            .alert(isPresented: $showPermissionDeniedAlert) {
                Alert(
                    title: Text("Location Access Required"),
                    message: Text("Please enable location access in Settings to use this feature."),
                    primaryButton: .default(Text("Settings"), action: openSettings),
                    secondaryButton: .cancel()
                )
            }
            .navigationDestination(isPresented: $navigateToSpaceView) {
                SpaceView(currentUser: currentUser)
            }
        }
    }
//fetchfriend
    private func fetchFriends() {
        if groupCode == "NY8282" {
            friends = allFriendGroups.filter { $0.name != currentUser.name }
            friends.insert(currentUser, at: 0)
        } else {
            friends = []
        }
    }
    //sharevia message
    private func shareGroupCodeViaMessage() {
        let message = "Join my group using code: \(groupCode)"
        let smsURLString = "sms:&body=\(message.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? "")"
        
        if let smsURL = URL(string: smsURLString), UIApplication.shared.canOpenURL(smsURL) {
            UIApplication.shared.open(smsURL)
        } else {
            guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                  let rootViewController = windowScene.windows.first?.rootViewController else {
                return
            }
            
            let activityVC = UIActivityViewController(
                activityItems: [message],
                applicationActivities: nil
            )
            rootViewController.present(activityVC, animated: true)
        }
    }
    //random location
    private func randomLocation(within radius: Double, center: CLLocationCoordinate2D) -> CLLocationCoordinate2D {
        let earthRadius = 6371000.0
        let maxDistance = radius / earthRadius
        
        let randomAngle = Double.random(in: 0..<2 * .pi)
        let randomDistance = sqrt(Double.random(in: 0..<1)) * maxDistance
        
        let newLat = center.latitude + (randomDistance * cos(randomAngle)) * (180 / .pi)
        let newLon = center.longitude + (randomDistance * sin(randomAngle)) * (180 / .pi) / cos(center.latitude * .pi / 180)
        
        return CLLocationCoordinate2D(latitude: newLat, longitude: newLon)
    }
    //location authorization but at present the current user is displayed at random coordinates as friends... 
    private func checkLocationAuthorization() {
        let status = locationManager.authorizationStatus
        if status == .notDetermined {
            locationManager.requestPermission()
        } else if status == .denied || status == .restricted {
            showPermissionDeniedAlert = true
        }
    }
    //location authorization
    private func handleAuthorizationStatus(_ status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            showPermissionDeniedAlert = true
        }
    }
    //popup for permission
    private func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
        UIApplication.shared.open(url)
    }
}

//Preview
struct UserIdView_Previews: PreviewProvider {
    static var previews: some View {
        UserIdView(
            groupCode: "NY8282",
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
