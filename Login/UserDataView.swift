// UserDataView Data Collection
//for now we can bypass the login process 
import SwiftUI
import CoreLocation

//Please use GroupCode "NY8282" to enter demo SpaceView.swift page

struct UserDataView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var groupCode: String = ""
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var selectedGender: String = "Select Gender"
    @State private var selectedCountry: String = "Select Country"
    @State private var selectedCity: String = "Select City"
    @State private var navigateToUserIdView = false
    @State private var currentUser: Friend? 
    @State private var showPopup: Bool = true  
    
    //country
    let genderOptions = ["Male", "Female", "Other"]
    let countryOptions = ["United States", "United Kingdom", "Canada", "Australia", 
                          "New Zealand", "India", "Germany", "Japan", "France", 
                          "Italy", "Switzerland", "Singapore", "Netherlands", "Czech Republic"]
    //At present i have used random coordinates to display location on map, I was thinking of using the backend to display current location but for now I have not connected it to backend..
    
    let cityLocationData: [String: [String: CLLocationCoordinate2D]] = [
        "United States": [
            "New York": CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060),
            "Los Angeles": CLLocationCoordinate2D(latitude: 34.0522, longitude: -118.2437),
            "Chicago": CLLocationCoordinate2D(latitude: 41.8781, longitude: -87.6298),
            "Houston": CLLocationCoordinate2D(latitude: 29.7604, longitude: -95.3698),
            "Phoenix": CLLocationCoordinate2D(latitude: 33.4484, longitude: -112.0740),
            "Philadelphia": CLLocationCoordinate2D(latitude: 39.9526, longitude: -75.1652),
            "San Antonio": CLLocationCoordinate2D(latitude: 29.4241, longitude: -98.4936),
            "San Diego": CLLocationCoordinate2D(latitude: 32.7157, longitude: -117.1611),
            "Dallas": CLLocationCoordinate2D(latitude: 32.7767, longitude: -96.7970),
            "San Jose": CLLocationCoordinate2D(latitude: 37.3382, longitude: -121.8863),
            "Austin": CLLocationCoordinate2D(latitude: 30.2672, longitude: -97.7431),
            "Jacksonville": CLLocationCoordinate2D(latitude: 30.3322, longitude: -81.6557),
            "San Francisco": CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
            "Seattle": CLLocationCoordinate2D(latitude: 47.6062, longitude: -122.3321),
            "Denver": CLLocationCoordinate2D(latitude: 39.7392, longitude: -104.9903),
            "Washington, D.C.": CLLocationCoordinate2D(latitude: 38.9072, longitude: -77.0369)
        ],
        
        "United Kingdom": [
            "London": CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278),
            "Birmingham": CLLocationCoordinate2D(latitude: 52.4862, longitude: -1.8904),
            "Manchester": CLLocationCoordinate2D(latitude: 53.4808, longitude: -2.2426),
            "Glasgow": CLLocationCoordinate2D(latitude: 55.8642, longitude: -4.2518),
            "Edinburgh": CLLocationCoordinate2D(latitude: 55.9533, longitude: -3.1883),
            "Liverpool": CLLocationCoordinate2D(latitude: 53.4084, longitude: -2.9916),
            "Bristol": CLLocationCoordinate2D(latitude: 51.4545, longitude: -2.5879),
            "Leeds": CLLocationCoordinate2D(latitude: 53.8008, longitude: -1.5491),
            "Leicester": CLLocationCoordinate2D(latitude: 52.6369, longitude: -1.1398),
            "Cambridge": CLLocationCoordinate2D(latitude: 52.2053, longitude: 0.1218)
        ],
        
        "Canada": [
            "Toronto": CLLocationCoordinate2D(latitude: 43.651070, longitude: -79.347015),
            "Vancouver": CLLocationCoordinate2D(latitude: 49.2827, longitude: -123.1207),
            "Montreal": CLLocationCoordinate2D(latitude: 45.5019, longitude: -73.5674),
            "Calgary": CLLocationCoordinate2D(latitude: 51.0447, longitude: -114.0719),
            "Ottawa": CLLocationCoordinate2D(latitude: 45.4215, longitude: -75.6972),
            "Edmonton": CLLocationCoordinate2D(latitude: 53.5461, longitude: -113.4938),
            "Winnipeg": CLLocationCoordinate2D(latitude: 49.8951, longitude: -97.1384),
            "Quebec City": CLLocationCoordinate2D(latitude: 46.8139, longitude: -71.2080),
            "Halifax": CLLocationCoordinate2D(latitude: 44.6488, longitude: -63.5752),
            "Victoria": CLLocationCoordinate2D(latitude: 48.4284, longitude: -123.3656)
        ],
        
        "Australia": [
            "Sydney": CLLocationCoordinate2D(latitude: -33.8688, longitude: 151.2093),
            "Melbourne": CLLocationCoordinate2D(latitude: -37.8136, longitude: 144.9631),
            "Brisbane": CLLocationCoordinate2D(latitude: -27.4698, longitude: 153.0251),
            "Perth": CLLocationCoordinate2D(latitude: -31.9505, longitude: 115.8605),
            "Adelaide": CLLocationCoordinate2D(latitude: -34.9285, longitude: 138.6007),
            "Canberra": CLLocationCoordinate2D(latitude: -35.2809, longitude: 149.1300),
            "Hobart": CLLocationCoordinate2D(latitude: -42.8821, longitude: 147.3272),
            "Darwin": CLLocationCoordinate2D(latitude: -12.4634, longitude: 130.8456),
            "Gold Coast": CLLocationCoordinate2D(latitude: -28.0167, longitude: 153.4000),
            "Newcastle": CLLocationCoordinate2D(latitude: -32.9267, longitude: 151.7789)
        ],
        
        "New Zealand": [
            "Auckland": CLLocationCoordinate2D(latitude: -36.8485, longitude: 174.7633),
            "Wellington": CLLocationCoordinate2D(latitude: -41.2865, longitude: 174.7762),
            "Christchurch": CLLocationCoordinate2D(latitude: -43.5321, longitude: 172.6362),
            "Hamilton": CLLocationCoordinate2D(latitude: -37.7870, longitude: 175.2793),
            "Tauranga": CLLocationCoordinate2D(latitude: -37.6878, longitude: 176.1651),
            "Dunedin": CLLocationCoordinate2D(latitude: -45.8788, longitude: 170.5028),
            "Palmerston North": CLLocationCoordinate2D(latitude: -40.3523, longitude: 175.6082),
            "Nelson": CLLocationCoordinate2D(latitude: -41.2706, longitude: 173.2840),
            "Napier": CLLocationCoordinate2D(latitude: -39.4928, longitude: 176.9120),
            "Invercargill": CLLocationCoordinate2D(latitude: -46.4132, longitude: 168.3538)
        ],
        
        "India": [
            "Mumbai": CLLocationCoordinate2D(latitude: 19.0760, longitude: 72.8777),
            "Delhi": CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025),
            "Bangalore": CLLocationCoordinate2D(latitude: 12.9716, longitude: 77.5946),
            "Hyderabad": CLLocationCoordinate2D(latitude: 17.3850, longitude: 78.4867),
            "Chennai": CLLocationCoordinate2D(latitude: 13.0827, longitude: 80.2707),
            "Kolkata": CLLocationCoordinate2D(latitude: 22.5726, longitude: 88.3639),
            "Pune": CLLocationCoordinate2D(latitude: 18.5204, longitude: 73.8567),
            "Ahmedabad": CLLocationCoordinate2D(latitude: 23.0225, longitude: 72.5714),
            "Jaipur": CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873),
            "Surat": CLLocationCoordinate2D(latitude: 21.1702, longitude: 72.8311)
        ],
        
        "Germany": [
            "Berlin": CLLocationCoordinate2D(latitude: 52.5200, longitude: 13.4050),
            "Munich": CLLocationCoordinate2D(latitude: 48.1351, longitude: 11.5820),
            "Hamburg": CLLocationCoordinate2D(latitude: 53.5511, longitude: 9.9937),
            "Frankfurt": CLLocationCoordinate2D(latitude: 50.1109, longitude: 8.6821),
            "Cologne": CLLocationCoordinate2D(latitude: 50.9375, longitude: 6.9603),
            "Stuttgart": CLLocationCoordinate2D(latitude: 48.7758, longitude: 9.1829),
            "Düsseldorf": CLLocationCoordinate2D(latitude: 51.2277, longitude: 6.7735),
            "Leipzig": CLLocationCoordinate2D(latitude: 51.3397, longitude: 12.3731),
            "Dortmund": CLLocationCoordinate2D(latitude: 51.5136, longitude: 7.4653),
            "Essen": CLLocationCoordinate2D(latitude: 51.4556, longitude: 7.0116)
        ],
        
        "Japan": [
            "Tokyo": CLLocationCoordinate2D(latitude: 35.6762, longitude: 139.6503),
            "Osaka": CLLocationCoordinate2D(latitude: 34.6937, longitude: 135.5023),
            "Kyoto": CLLocationCoordinate2D(latitude: 35.0116, longitude: 135.7681),
            "Yokohama": CLLocationCoordinate2D(latitude: 35.4437, longitude: 139.6380),
            "Nagoya": CLLocationCoordinate2D(latitude: 35.1815, longitude: 136.9066),
            "Sapporo": CLLocationCoordinate2D(latitude: 43.0618, longitude: 141.3545),
            "Fukuoka": CLLocationCoordinate2D(latitude: 33.5904, longitude: 130.4017),
            "Kobe": CLLocationCoordinate2D(latitude: 34.6901, longitude: 135.1955),
            "Hiroshima": CLLocationCoordinate2D(latitude: 34.3853, longitude: 132.4553),
            "Sendai": CLLocationCoordinate2D(latitude: 38.2682, longitude: 140.8694)
        ],
        
        "France": [
            "Paris": CLLocationCoordinate2D(latitude: 48.8566, longitude: 2.3522),
            "Marseille": CLLocationCoordinate2D(latitude: 43.2965, longitude: 5.3698),
            "Lyon": CLLocationCoordinate2D(latitude: 45.7640, longitude: 4.8357),
            "Toulouse": CLLocationCoordinate2D(latitude: 43.6047, longitude: 1.4442),
            "Nice": CLLocationCoordinate2D(latitude: 43.7102, longitude: 7.2620),
            "Nantes": CLLocationCoordinate2D(latitude: 47.2184, longitude: -1.5536),
            "Strasbourg": CLLocationCoordinate2D(latitude: 48.5734, longitude: 7.7521),
            "Bordeaux": CLLocationCoordinate2D(latitude: 44.8378, longitude: -0.5792),
            "Lille": CLLocationCoordinate2D(latitude: 50.6292, longitude: 3.0573),
            "Rennes": CLLocationCoordinate2D(latitude: 48.1173, longitude: -1.6778)
        ],
        
        "Italy": [
            "Rome": CLLocationCoordinate2D(latitude: 41.9028, longitude: 12.4964),
            "Milan": CLLocationCoordinate2D(latitude: 45.4642, longitude: 9.1900),
            "Naples": CLLocationCoordinate2D(latitude: 40.8522, longitude: 14.2681),
            "Turin": CLLocationCoordinate2D(latitude: 45.0703, longitude: 7.6869),
            "Palermo": CLLocationCoordinate2D(latitude: 38.1157, longitude: 13.3615),
            "Genoa": CLLocationCoordinate2D(latitude: 44.4056, longitude: 8.9463),
            "Bologna": CLLocationCoordinate2D(latitude: 44.4949, longitude: 11.3426),
            "Florence": CLLocationCoordinate2D(latitude: 43.7696, longitude: 11.2558),
            "Venice": CLLocationCoordinate2D(latitude: 45.4408, longitude: 12.3155),
            "Bari": CLLocationCoordinate2D(latitude: 41.1171, longitude: 16.8719)
        ],
        
        "Switzerland": [
            "Zurich": CLLocationCoordinate2D(latitude: 47.3769, longitude: 8.5417),
            "Geneva": CLLocationCoordinate2D(latitude: 46.2044, longitude: 6.1432),
            "Basel": CLLocationCoordinate2D(latitude: 47.5596, longitude: 7.5886),
            "Lausanne": CLLocationCoordinate2D(latitude: 46.5197, longitude: 6.6323),
            "Bern": CLLocationCoordinate2D(latitude: 46.9480, longitude: 7.4474),
            "Lucerne": CLLocationCoordinate2D(latitude: 47.0502, longitude: 8.3093),
            "St. Gallen": CLLocationCoordinate2D(latitude: 47.4245, longitude: 9.3767),
            "Lugano": CLLocationCoordinate2D(latitude: 46.0037, longitude: 8.9511),
            "Winterthur": CLLocationCoordinate2D(latitude: 47.5000, longitude: 8.7241),
            "Fribourg": CLLocationCoordinate2D(latitude: 46.8065, longitude: 7.1617)
        ],
        
        "Singapore": [
            "Singapore": CLLocationCoordinate2D(latitude: 1.3521, longitude: 103.8198)
        ],
        
        "Netherlands": [
            "Amsterdam": CLLocationCoordinate2D(latitude: 52.3676, longitude: 4.9041),
            "Rotterdam": CLLocationCoordinate2D(latitude: 51.9244, longitude: 4.4777),
            "The Hague": CLLocationCoordinate2D(latitude: 52.0705, longitude: 4.3007),
            "Utrecht": CLLocationCoordinate2D(latitude: 52.0907, longitude: 5.1214),
            "Eindhoven": CLLocationCoordinate2D(latitude: 51.4416, longitude: 5.4697),
            "Groningen": CLLocationCoordinate2D(latitude: 53.2194, longitude: 6.5665),
            "Maastricht": CLLocationCoordinate2D(latitude: 50.8514, longitude: 5.6910),
            "Haarlem": CLLocationCoordinate2D(latitude: 52.3874, longitude: 4.6462),
            "Leiden": CLLocationCoordinate2D(latitude: 52.1601, longitude: 4.4970),
            "Delft": CLLocationCoordinate2D(latitude: 52.0116, longitude: 4.3571)
        ],
        
        "Czech Republic": [
            "Prague": CLLocationCoordinate2D(latitude: 50.0755, longitude: 14.4378),
            "Brno": CLLocationCoordinate2D(latitude: 49.1951, longitude: 16.6068),
            "Ostrava": CLLocationCoordinate2D(latitude: 49.8209, longitude: 18.2625),
            "Plzen": CLLocationCoordinate2D(latitude: 49.7384, longitude: 13.3736),
            "Liberec": CLLocationCoordinate2D(latitude: 50.7663, longitude: 15.0543),
            "Olomouc": CLLocationCoordinate2D(latitude: 49.5938, longitude: 17.2509),
            "Ceske Budejovice": CLLocationCoordinate2D(latitude: 48.9745, longitude: 14.4747),
            "Hradec Kralove": CLLocationCoordinate2D(latitude: 50.2104, longitude: 15.8252),
            "Pardubice": CLLocationCoordinate2D(latitude: 50.0343, longitude: 15.7812),
            "Zlin": CLLocationCoordinate2D(latitude: 49.2266, longitude: 17.6687)
        ]
    ]
    
    var citiesForSelectedCountry: [String] {
        cityLocationData[selectedCountry]?.keys.sorted() ?? []
    }
   
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
                        Text("Your Profile")
                            .font(.largeTitle)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                        
                        //firstname
                        userInputField(title: "First Name", text: $firstName, placeholder: "Enter your first name")
                        
                       //surename
                        userInputField(title: "Last Name", text: $lastName, placeholder: "Enter your last name")
                        
                        
                        genderPicker()
                        //groupcode
                        userInputField(title: "Group Code", text: $groupCode, placeholder: "Enter your group code")
                        
                        countryDropdown()
                        //country
                        if selectedCountry != "Select Country" {
                            cityDropdown()
                        }
     
                        Button(action: {
                            if validateForm() {
          
                                let location = cityLocationData[selectedCountry]?[selectedCity] ?? CLLocationCoordinate2D(latitude: 0.0, longitude: 0.0)
                                
                                currentUser = Friend(
                                    name: "\(firstName) \(lastName)",
                                    location: location,
                                    color: Color.random(),
                                    phoneNumber: "N/A"
                                )
                                navigateToUserIdView = true
                            } else {
                                showError = true
                            }
                        }) { 
                            Text("Submit")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                                .background(Color.clear)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 30)
                        .padding(.top, 20)
                        
                        Spacer(minLength: 50)
                    }
                    .padding(.bottom, 50) 
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                .navigationDestination(isPresented: $navigateToUserIdView) {
                    if let user = currentUser {
                        UserIdView(groupCode: groupCode, currentUser: user)
                    }
                }
                
                //popup
                if showPopup {
                    CustomPopup2(isVisible: $showPopup)
                        .transition(.opacity)
                }
            }
        }
    }
    
    //logic for validation of userdata
    func validateForm() -> Bool {
        if firstName.isEmpty {
            errorMessage = "First Name is required."
            return false
        }
        if lastName.isEmpty {
            errorMessage = "Last Name is required."
            return false
        }
        if selectedGender == "Select Gender" {
            errorMessage = "Please select a gender."
            return false
        }
        if groupCode.isEmpty {
            errorMessage = "Group Code is required."
            return false
        }
        if selectedCountry == "Select Country" {
            errorMessage = "Please select a country."
            return false
        }
        if selectedCity == "Select City" {
            errorMessage = "Please select a city."
            return false
        }
        return true
    }
    
    //user entry field
    func userInputField(title: String, text: Binding<String>, placeholder: String) -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            TextField(placeholder, text: text)
                .font(.system(size: 18))
                .padding()
                .background(Color(white: 0.1))
                .cornerRadius(8)
                .foregroundColor(.white)
        }
        .padding(.horizontal, 30)
    }
    
    func genderPicker() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Gender")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Menu {
                ForEach(genderOptions, id: \.self) { option in
                    Button(action: {
                        selectedGender = option
                    }) {
                        Text(option)
                    }
                }
            } label: {
                HStack {
                    Text(selectedGender)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(white: 0.1))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 30)
    }
    //scroll option is not fesible look for different options 
    func countryDropdown() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Country")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Menu {
                ForEach(countryOptions, id: \.self) { country in
                    Button(action: {
                        selectedCountry = country
                        selectedCity = "Select City" 
                    }) {
                        Text(country)
                    }
                }
            } label: {
                HStack {
                    Text(selectedCountry)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(white: 0.1))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 30)
    }
    //can use dropdown it works properly
    func cityDropdown() -> some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("City")
                .font(.system(size: 16, weight: .medium))
                .foregroundColor(.white)
            
            Menu {
                ScrollView {
                    VStack {
                        ForEach(citiesForSelectedCountry, id: \.self) { city in
                            Button(action: {
                                selectedCity = city
                            }) {
                                Text(city)
                                    .foregroundColor(.primary)
                            }
                        }
                    }
                }
                .frame(maxHeight: 150) 
            } label: {
                HStack {
                    Text(selectedCity)
                        .font(.system(size: 18))
                        .foregroundColor(.white)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
                .padding()
                .background(Color(white: 0.1))
                .cornerRadius(8)
            }
        }
        .padding(.horizontal, 30)
    }
}

//colour can been assigned randomly 
extension Color {
    static func random() -> Color {
        return Color(
            red: Double.random(in: 0.3...1.0),
            green: Double.random(in: 0.3...1.0),
            blue: Double.random(in: 0.3...1.0)
        )
    }
}
//preview
struct UserDataView_Previews: PreviewProvider {
    static var previews: some View {
        UserDataView()
            .preferredColorScheme(.dark)
    }
}
