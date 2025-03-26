//First Aid guide with common emergencies
import SwiftUI

struct Chapter: Identifiable {
    let id = UUID()
    let number: Int
    let icon: String
    let title: String
    let color: Color
    
}

struct ContentView: View {
    @Environment(\.presentationMode) var presentationMode
    
    let chapters: [Chapter] = [
        Chapter(number: 1, icon: "heart.fill", title: "CPR", color: .red, destination: AnyView(CPRGuide())),
        Chapter(number: 2, icon: "stethoscope", title: "Severe Chest Pain", color: .orange, destination: AnyView(SevereChestPainView())),
        Chapter(number: 3, icon: "lungs.fill", title: "Choking", color: .blue, destination: AnyView(ChokingView())),
        Chapter(number: 4, icon: "flame.fill", title: "Period Pain", color: .red, destination: AnyView(PeriodPainView())),
        Chapter(number: 5, icon: "brain.head.profile", title: "Depression", color: .purple, destination: AnyView(DepressionView())),
        Chapter(number: 6, icon: "car.fill", title: "Roadside Emergencies", color: .green, destination: AnyView(RoadsideEmergenciesView())),
        Chapter(number: 7, icon: "wind", title: "Stress", color: .yellow, destination: AnyView(StressView())),
        Chapter(number: 8, icon: "eye.fill", title: "Fear", color: .pink, destination: AnyView(FearView())),
        Chapter(number: 9, icon: "house.fill", title: "Homesickness", color: .blue, destination: AnyView(HomesicknessView())),
        Chapter(number: 10, icon: "heart.slash.fill", title: "Heart Attack Symptoms", color: .red, destination: AnyView(HeartAttackSymptomsView())),
        Chapter(number: 11, icon: "bandage.fill", title: "Head Injury", color: .orange, destination: AnyView(HeadInjuryView())),
        Chapter(number: 12, icon: "flame.fill", title: "Severe Burns", color: .red, destination: AnyView(SevereBurnsView())),
        Chapter(number: 13, icon: "drop.fill", title: "Heavy Bleeding", color: .red, destination: AnyView(HeavyBleedingView())),
        Chapter(number: 14, icon: "exclamationmark.triangle.fill", title: "Suicidal Thoughts", color: .red, destination: AnyView(SuicidalThoughtsView()))
    ]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading, spacing: 15) {
                    Text("In an Emergency, every second matters.")
                        .font(.title2)
                        .fontWeight(.bold)
                        .padding(.horizontal)
                        .padding(.top)
                    
                    ForEach(chapters) { chapter in
                        NavigationLink(destination: chapter.destination) {
                            ChapterRow(number: chapter.number, icon: chapter.icon, title: chapter.title, color: chapter.color)
                        }
                    }
                }
                .padding(.vertical)
            }
            .background(Color(.systemBackground))
            .navigationTitle("First Aid Guide")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundColor(.blue)
                    }
                }
            }
        }
    }
}
//reusable Chapter Row Component
struct ChapterRow: View {
    let number: Int
    let icon: String
    let title: String
    let color: Color
    
    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
                .frame(width: 30)
            
            Text("Chapter \(number): \(title)")
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

//CPR
struct CPRGuide: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //CPR Image
                Image("Cpr") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("How to Perform CPR")
                    .font(.largeTitle)
                    .bold()
                
                //steps for CPR
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Check Responsiveness", description: "Gently shake the person and shout, 'Are you okay?' If there's no response, proceed to the next step.")
                    
                    StepView(stepNumber: 2, title: "Call for Help", description: "Call emergency services or ask someone nearby to call. If alone, call before starting CPR.")
                    
                    StepView(stepNumber: 3, title: "Open the Airway", description: "Place the person on their back. Tilt their head back slightly and lift their chin to open the airway.")
                    
                    StepView(stepNumber: 4, title: "Check for Breathing", description: "Look, listen, and feel for breathing for no more than 10 seconds. If the person isn't breathing, start CPR.")
                    
                    StepView(stepNumber: 5, title: "Start Chest Compressions", description: "Place the heel of one hand on the center of the chest. Place the other hand on top and interlock your fingers. Push hard and fast (2 inches deep at 100-120 compressions per minute).")
                    
                    StepView(stepNumber: 6, title: "Give Rescue Breaths", description: "After 30 compressions, give 2 rescue breaths. Tilt the head back, pinch the nose, and blow into the mouth until the chest rises.")
                    
                    StepView(stepNumber: 7, title: "Continue CPR", description: "Repeat cycles of 30 compressions and 2 breaths until help arrives or the person starts breathing.")
                }
                .padding(.vertical)
                
                //endnote
                Text("Note: If you're untrained or unsure, perform hands-only CPR (chest compressions without rescue breaths).")
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding()
        }
        .navigationTitle("CPR Guide")
    }
}

//Severe Chest Pain View
struct SevereChestPainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("pain") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Severe Chest Pain")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Call Emergency Services", description: "Dial emergency services immediately. Chest pain could indicate a heart attack.")
                    
                    StepView(stepNumber: 2, title: "Keep the Person Calm", description: "Help the person sit down and stay calm. Loosen tight clothing.")
                    
                    StepView(stepNumber: 3, title: "Monitor Symptoms", description: "Watch for symptoms like shortness of breath, sweating, or nausea.")
                    
                    StepView(stepNumber: 4, title: "Do Not Delay", description: "Time is critical. Do not wait to see if the pain goes away.")
                    
                    StepView(stepNumber: 5, title: "Chew Aspirin", description: "If advised by a doctor, chew an aspirin to thin the blood and improve blood flow.")
                    
                    StepView(stepNumber: 6, title: "Avoid Physical Activity", description: "Keep the person still and avoid any unnecessary movement.")
                    
                    StepView(stepNumber: 7, title: "Check for Allergies", description: "Ensure the person is not allergic to aspirin before administering.")
                    
                    StepView(stepNumber: 8, title: "Stay with the Person", description: "Provide reassurance and stay with them until help arrives.")
                    
                    StepView(stepNumber: 9, title: "Prepare for CPR", description: "If the person becomes unresponsive, be ready to perform CPR.")
                    
                    StepView(stepNumber: 10, title: "Note the Time", description: "Record when the symptoms started to inform medical professionals.")
                    
                    StepView(stepNumber: 11, title: "Avoid Food or Drink", description: "Do not give the person anything to eat or drink.")
                    
                    StepView(stepNumber: 12, title: "Follow Up", description: "After the incident, follow medical advice for recovery and prevention.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Chest Pain")
    }
}
//choking View
struct ChokingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("choking") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //Title
                Text("Choking")
                    .font(.largeTitle)
                    .bold()
                
                //Steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Assess the Situation", description: "Ask the person if they are choking. If they can cough or speak, encourage them to keep coughing.")
                    
                    StepView(stepNumber: 2, title: "Perform Abdominal Thrusts", description: "Stand behind the person, wrap your arms around their waist, and perform quick upward thrusts.")
                    
                    StepView(stepNumber: 3, title: "Call for Help", description: "If the person becomes unconscious, call emergency services and begin CPR.")
                    
                    StepView(stepNumber: 4, title: "Check the Mouth", description: "If you see the object, try to remove it with your fingers. Be careful not to push it further.")
                    
                    StepView(stepNumber: 5, title: "Modify for Pregnant or Obese Individuals", description: "Perform chest thrusts instead of abdominal thrusts.")
                    
                    StepView(stepNumber: 6, title: "Encourage Coughing", description: "If the person is coughing forcefully, let them continue to try to clear the blockage.")
                    
                    StepView(stepNumber: 7, title: "Position the Person", description: "Bend them forward slightly to help dislodge the object.")
                    
                    StepView(stepNumber: 8, title: "Monitor Breathing", description: "Ensure the person is breathing normally after the object is dislodged.")
                    
                    StepView(stepNumber: 9, title: "Stay Calm", description: "Keep the person calm and reassure them throughout the process.")
                    
                    StepView(stepNumber: 10, title: "Follow Up", description: "Even if the object is removed, seek medical attention to ensure no internal damage.")
                    
                    StepView(stepNumber: 11, title: "Learn CPR", description: "Take a CPR course to be prepared for future emergencies.")
                    
                    StepView(stepNumber: 12, title: "Prevent Choking", description: "Cut food into small pieces, avoid talking while eating, and supervise children during meals.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Choking")
    }
}
//Burns View
struct PeriodPainView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                // Image
                Image("period") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("PeriodPain")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Apply Heat", description: "Use a heating pad or hot water bottle on your lower abdomen to relax muscles and reduce pain.")
                    
                    StepView(stepNumber: 2, title: "Take Pain Relievers", description: "Over-the-counter pain relievers like ibuprofen or acetaminophen can help reduce pain and inflammation.")
                    
                    StepView(stepNumber: 3, title: "Stay Hydrated", description: "Drink plenty of water to reduce bloating and ease cramps.")
                    
                    StepView(stepNumber: 4, title: "Exercise", description: "Light exercise like walking or yoga can improve blood flow and reduce pain.")
                    
                    StepView(stepNumber: 6, title: "Avoid Caffeine", description: "Caffeine can worsen cramps, so limit coffee, tea, and energy drinks.")
                    
                    StepView(stepNumber: 7, title: "Eat Healthy", description: "Include foods rich in magnesium, calcium, and omega-3 fatty acids to reduce pain.")
                    
                    StepView(stepNumber: 8, title: "Rest", description: "Get enough sleep and rest to help your body recover.")
                    
                    StepView(stepNumber: 9, title: "Try Herbal Teas", description: "Drink chamomile or ginger tea to relax muscles and reduce pain.")
                    
                    StepView(stepNumber: 10, title: "Use Essential Oils", description: "Lavender or clary sage oils can help relieve pain when used in aromatherapy.")
                    
                    StepView(stepNumber: 11, title: "Consult a Doctor", description: "If pain is severe or persistent, consult a healthcare professional for advice.")
                    
                    StepView(stepNumber: 12, title: "Track Symptoms", description: "Keep a journal of your symptoms to identify patterns and triggers.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Period")
    }
}

//Depression View
struct DepressionView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("depression") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Depression")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Recognize the Signs", description: "Look for symptoms like persistent sadness, loss of interest in activities, fatigue, and changes in sleep or appetite.")
                    
                    StepView(stepNumber: 2, title: "Listen Without Judgment", description: "Offer a safe space for the person to express their feelings.")
                    
                    StepView(stepNumber: 3, title: "Encourage Professional Help", description: "Suggest therapy or counseling as a way to manage depression.")
                    
                    StepView(stepNumber: 4, title: "Avoid Minimizing Their Feelings", description: "Do not say things like 'snap out of it' or 'it’s all in your head.'")
                    
                    StepView(stepNumber: 5, title: "Stay Connected", description: "Regularly check in on the person to show support.")
                    
                    StepView(stepNumber: 6, title: "Encourage Healthy Habits", description: "Suggest exercise, a balanced diet, and adequate sleep.")
                    
                    StepView(stepNumber: 7, title: "Help Them Set Small Goals", description: "Break tasks into manageable steps to avoid overwhelming them.")
                    
                    StepView(stepNumber: 8, title: "Be Patient", description: "Recovery takes time; avoid pressuring them to 'get better' quickly.")
                    
                    StepView(stepNumber: 9, title: "Educate Yourself", description: "Learn about depression to better understand their experience.")
                    
                    StepView(stepNumber: 10, title: "Emergency Plan", description: "If they express suicidal thoughts, seek immediate professional help.")
                    
                    StepView(stepNumber: 11, title: "Avoid Isolation", description: "Encourage social interaction, even if it’s just a short walk or coffee.")
                    
                    StepView(stepNumber: 12, title: "Monitor Medication", description: "If prescribed, ensure they take it as directed and watch for side effects.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Depression")
    }
}

//roadside Emergencies View
struct RoadsideEmergenciesView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("accident") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Roadside Emergencies")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Stay Calm", description: "Assess the situation without panicking.")
                    
                    StepView(stepNumber: 2, title: "Ensure Safety", description: "Move to a safe location, like the side of the road, if possible.")
                    
                    StepView(stepNumber: 3, title: "Turn on Hazard Lights", description: "Alert other drivers to your situation.")
                    
                    StepView(stepNumber: 4, title: "Call for Help", description: "Dial emergency services or roadside assistance.")
                    
                    StepView(stepNumber: 5, title: "Use Reflective Triangles", description: "Place them at a safe distance to warn oncoming traffic.")
                    
                    StepView(stepNumber: 6, title: "Stay in the Vehicle", description: "If it’s unsafe to exit, remain inside with seatbelts on.")
                    
                    StepView(stepNumber: 7, title: "Provide First Aid", description: "If someone is injured, administer basic first aid while waiting for help.")
                    
                    StepView(stepNumber: 8, title: "Document the Incident", description: "Take photos and note details for insurance purposes.")
                    
                    StepView(stepNumber: 9, title: "Avoid Confrontations", description: "If another driver is involved, remain calm and avoid arguments.")
                    
                    StepView(stepNumber: 10, title: "Keep Emergency Supplies", description: "Have a kit with water, blankets, a flashlight, and a first aid kit.")
                    
                    StepView(stepNumber: 11, title: "Know Your Location", description: "Use GPS or landmarks to describe your location to emergency services.")
                    
                    StepView(stepNumber: 12, title: "Follow Up", description: "After the incident, ensure your vehicle is repaired and you’re emotionally okay.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Roadside Emergencies")
    }
}

//stress View
struct StressView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("Stress") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Stress")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Identify Triggers", description: "Recognize what causes your stress.")
                    
                    StepView(stepNumber: 2, title: "Practice Deep Breathing", description: "Use techniques like inhaling for 4 seconds, holding for 4 seconds, and exhaling for 6 seconds.")
                    
                    StepView(stepNumber: 3, title: "Exercise Regularly", description: "Physical activity helps reduce stress hormones.")
                    
                    StepView(stepNumber: 4, title: "Prioritize Tasks", description: "Focus on what’s most important and break tasks into smaller steps.")
                    
                    StepView(stepNumber: 5, title: "Take Breaks", description: "Step away from stressful situations to clear your mind.")
                    
                    StepView(stepNumber: 6, title: "Talk to Someone", description: "Share your feelings with a trusted friend or therapist.")
                    
                    StepView(stepNumber: 7, title: "Limit Caffeine and Alcohol", description: "These can exacerbate stress.")
                    
                    StepView(stepNumber: 8, title: "Practice Mindfulness", description: "Engage in meditation or yoga to stay present.")
                    
                    StepView(stepNumber: 9, title: "Get Enough Sleep", description: "Aim for 7-9 hours per night.")
                    
                    StepView(stepNumber: 10, title: "Set Boundaries", description: "Learn to say no to avoid overcommitting.")
                    
                    StepView(stepNumber: 11, title: "Engage in Hobbies", description: "Do activities you enjoy to distract yourself.")
                    
                    StepView(stepNumber: 12, title: "Seek Professional Help", description: "If stress becomes unmanageable, consult a therapist.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Stress")
    }
}

//Fear View
struct FearView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("fear") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Fear")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Acknowledge the Fear", description: "Accept that you’re feeling afraid.")
                    
                    StepView(stepNumber: 2, title: "Identify the Source", description: "Determine what’s causing the fear.")
                    
                    StepView(stepNumber: 3, title: "Breathe Deeply", description: "Use calming breathing techniques to reduce anxiety.")
                    
                    StepView(stepNumber: 4, title: "Challenge Negative Thoughts", description: "Replace irrational fears with rational ones.")
                    
                    StepView(stepNumber: 5, title: "Visualize Success", description: "Imagine yourself overcoming the fear.")
                    
                    StepView(stepNumber: 6, title: "Take Small Steps", description: "Gradually face the fear in manageable increments.")
                    
                    StepView(stepNumber: 7, title: "Seek Support", description: "Talk to friends, family, or a therapist.")
                    
                    StepView(stepNumber: 8, title: "Practice Relaxation Techniques", description: "Try meditation or progressive muscle relaxation.")
                    
                    StepView(stepNumber: 9, title: "Limit Exposure to Triggers", description: "Avoid situations that amplify your fear if possible.")
                    
                    StepView(stepNumber: 10, title: "Educate Yourself", description: "Learn more about what you fear to demystify it.")
                    
                    StepView(stepNumber: 11, title: "Celebrate Progress", description: "Reward yourself for facing your fears.")
                    
                    StepView(stepNumber: 12, title: "Consider Therapy", description: "Cognitive Behavioral Therapy (CBT) can be highly effective.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Fear")
    }
}

//Homesickness View
struct HomesicknessView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("homesick")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Homesickness")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Acknowledge Your Feelings", description: "Accept that it’s normal to feel homesick.")
                    
                    StepView(stepNumber: 2, title: "Stay Connected", description: "Regularly call or video chat with loved ones.")
                    
                    StepView(stepNumber: 3, title: "Create a Routine", description: "Establish a daily schedule to provide structure.")
                    
                    StepView(stepNumber: 4, title: "Bring Comforts from Home", description: "Keep familiar items like photos or mementos.")
                    
                    StepView(stepNumber: 5, title: "Explore Your New Environment", description: "Get to know your surroundings to feel more at home.")
                    
                    StepView(stepNumber: 6, title: "Make New Friends", description: "Build a support network in your new location.")
                    
                    StepView(stepNumber: 7, title: "Stay Busy", description: "Engage in activities or hobbies to distract yourself.")
                    
                    StepView(stepNumber: 8, title: "Practice Self-Care", description: "Eat well, exercise, and get enough sleep.")
                    
                    StepView(stepNumber: 9, title: "Write in a Journal", description: "Express your feelings to process them.")
                    
                    StepView(stepNumber: 10, title: "Set Goals", description: "Focus on what you want to achieve in your new environment.")
                    
                    StepView(stepNumber: 11, title: "Seek Professional Help", description: "If homesickness persists, consider therapy.")
                    
                    StepView(stepNumber: 12, title: "Give It Time", description: "Adjusting to a new place takes time; be patient with yourself.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Homesickness")
    }
}

//Heart Attack Symptoms View
struct HeartAttackSymptomsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("Heartattack") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Heart Attack Symptoms")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Recognize Symptoms", description: "Chest pain, shortness of breath, nausea, and cold sweats.")
                    
                    StepView(stepNumber: 2, title: "Call Emergency Services", description: "Dial for help immediately.")
                    
                    StepView(stepNumber: 3, title: "Chew Aspirin", description: "If advised by a doctor, chew an aspirin to thin the blood.")
                    
                    StepView(stepNumber: 4, title: "Stay Calm", description: "Keep the person calm and seated.")
                    
                    StepView(stepNumber: 5, title: "Loosen Tight Clothing", description: "Remove or loosen restrictive clothing.")
                    
                    StepView(stepNumber: 6, title: "Monitor Breathing", description: "Ensure the person is breathing normally.")
                    
                    StepView(stepNumber: 7, title: "Perform CPR if Necessary", description: "If the person becomes unresponsive, start CPR.")
                    
                    StepView(stepNumber: 8, title: "Do Not Drive Yourself", description: "Wait for an ambulance.")
                    
                    StepView(stepNumber: 9, title: "Keep the Person Warm", description: "Use a blanket to prevent shock.")
                    
                    StepView(stepNumber: 10, title: "Avoid Food or Drink", description: "Do not give the person anything to eat or drink.")
                    
                    StepView(stepNumber: 11, title: "Stay with Them", description: "Provide reassurance until help arrives.")
                    
                    StepView(stepNumber: 12, title: "Follow Up", description: "After the incident, follow medical advice for recovery.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Heart Attack Symptoms")
    }
}

//head Injury View
struct HeadInjuryView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //image
                Image("pain") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Head Injury")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Call Emergency Services", description: "Seek immediate medical attention.")
                    
                    StepView(stepNumber: 2, title: "Keep the Person Still", description: "Do not move them unless necessary.")
                    
                    StepView(stepNumber: 3, title: "Check for Breathing", description: "Ensure they are breathing normally.")
                    
                    StepView(stepNumber: 4, title: "Monitor Consciousness", description: "Note if they regain consciousness or remain unconscious.")
                    
                    StepView(stepNumber: 5, title: "Control Bleeding", description: "Apply gentle pressure to any bleeding wounds.")
                    
                    StepView(stepNumber: 6, title: "Avoid Giving Food or Drink", description: "They may choke if unconscious.")
                    
                    StepView(stepNumber: 7, title: "Keep Them Warm", description: "Use a blanket to prevent shock.")
                    
                    StepView(stepNumber: 8, title: "Do Not Shake Them", description: "Avoid shaking or slapping the person.")
                    
                    StepView(stepNumber: 9, title: "Watch for Vomiting", description: "Turn their head to the side to prevent choking.")
                    
                    StepView(stepNumber: 10, title: "Record Symptoms", description: "Note any confusion, dizziness, or memory loss.")
                    
                    StepView(stepNumber: 11, title: "Follow Medical Advice", description: "Adhere to treatment plans after the incident.")
                    
                    StepView(stepNumber: 12, title: "Rest and Recover", description: "Allow time for the brain to heal.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Head Injury")
    }
}

//Severe Burns View
struct SevereBurnsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //Image
                Image("burn")
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Severe Burns")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Remove the Source", description: "Stop contact with the heat, chemical, or electricity.")
                    
                    StepView(stepNumber: 2, title: "Cool the Burn", description: "Run cool (not cold) water over the burn for 10-20 minutes.")
                    
                    StepView(stepNumber: 3, title: "Remove Jewelry", description: "Take off any tight items near the burn.")
                    
                    StepView(stepNumber: 4, title: "Cover the Burn", description: "Use a sterile, non-stick bandage or cloth.")
                    
                    StepView(stepNumber: 5, title: "Do Not Pop Blisters", description: "This can lead to infection.")
                    
                    StepView(stepNumber: 6, title: "Avoid Home Remedies", description: "Do not apply butter, oil, or ice.")
                    
                    StepView(stepNumber: 7, title: "Seek Medical Help", description: "For severe burns, call emergency services.")
                    
                    StepView(stepNumber: 8, title: "Monitor for Shock", description: "Keep the person warm and calm.")
                    
                    StepView(stepNumber: 9, title: "Elevate the Burn", description: "Raise the burned area above heart level if possible.")
                    
                    StepView(stepNumber: 10, title: "Stay Hydrated", description: "Burns can cause fluid loss; drink water.")
                    
                    StepView(stepNumber: 11, title: "Follow Up", description: "Adhere to medical advice for wound care.")
                    
                    StepView(stepNumber: 12, title: "Prevent Infection", description: "Keep the burn clean and dry.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Severe Burns")
    }
}

//heavy Bleeding View
struct HeavyBleedingView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //image
                Image("Bleeding") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Heavy Bleeding")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Apply Direct Pressure", description: "Use a clean cloth or bandage to press on the wound.")
                    
                    StepView(stepNumber: 2, title: "Elevate the Injury", description: "Raise the bleeding area above heart level.")
                    
                    StepView(stepNumber: 3, title: "Call for Help", description: "Dial emergency services immediately.")
                    
                    StepView(stepNumber: 4, title: "Use a Tourniquet", description: "Only as a last resort for life-threatening bleeding.")
                    
                    StepView(stepNumber: 5, title: "Keep the Person Calm", description: "Reassure them to prevent shock.")
                    
                    StepView(stepNumber: 6, title: "Monitor Breathing", description: "Ensure they are breathing normally.")
                    
                    StepView(stepNumber: 7, title: "Do Not Remove Cloth", description: "If blood soaks through, add more layers.")
                    
                    StepView(stepNumber: 8, title: "Clean the Wound", description: "Once bleeding stops, clean with water if possible.")
                    
                    StepView(stepNumber: 9, title: "Apply Antibiotic Ointment", description: "Use if available to prevent infection.")
                    
                    StepView(stepNumber: 10, title: "Cover the Wound", description: "Use a sterile bandage or cloth.")
                    
                    StepView(stepNumber: 11, title: "Watch for Signs of Shock", description: "Pale skin, rapid breathing, or dizziness.")
                    
                    StepView(stepNumber: 12, title: "Follow Up", description: "Seek medical attention for proper wound care.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Heavy Bleeding")
    }
}

//suicidal Thoughts View
struct SuicidalThoughtsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                //image
                Image("Suicidal") 
                    .resizable()
                    .scaledToFit()
                    .cornerRadius(12)
                    .padding(.vertical)
                
                //title
                Text("Suicidal Thoughts")
                    .font(.largeTitle)
                    .bold()
                
                //steps
                VStack(alignment: .leading, spacing: 15) {
                    StepView(stepNumber: 1, title: "Take It Seriously", description: "Do not dismiss or ignore suicidal statements.")
                    
                    StepView(stepNumber: 2, title: "Listen Without Judgment", description: "Offer a safe space for them to talk.")
                    
                    StepView(stepNumber: 3, title: "Ask Direct Questions", description: "Inquire if they have a plan or means to harm themselves.")
                    
                    StepView(stepNumber: 4, title: "Remove Dangerous Items", description: "Safely remove weapons, medications, or other hazards.")
                    
                    StepView(stepNumber: 5, title: "Stay with Them", description: "Do not leave them alone if they are in immediate danger.")
                    
                    StepView(stepNumber: 6, title: "Call for Help", description: "Contact a crisis hotline or emergency services.")
                    
                    StepView(stepNumber: 7, title: "Encourage Professional Help", description: "Suggest therapy or counseling.")
                    
                    StepView(stepNumber: 8, title: "Create a Safety Plan", description: "Help them identify coping strategies and support systems.")
                    
                    StepView(stepNumber: 9, title: "Follow Up", description: "Regularly check in on their well-being.")
                    
                    StepView(stepNumber: 10, title: "Educate Yourself", description: "Learn about suicide prevention and warning signs.")
                    
                    StepView(stepNumber: 11, title: "Avoid Blame", description: "Do not make them feel guilty for their feelings.")
                    
                    StepView(stepNumber: 12, title: "Provide Hope", description: "Remind them that help is available and things can improve.")
                }
                .padding(.vertical)
            }
            .padding()
        }
        .navigationTitle("Suicidal Thoughts")
    }
}

//Step View Component
struct StepView: View {
    let stepNumber: Int
    let title: String
    let description: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 10) {
            Text("\(stepNumber).")
                .font(.headline)
                .foregroundColor(.blue)
            
            VStack(alignment: .leading, spacing: 5) {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.primary)
                
                Text(description)
                    .font(.body)
                    .foregroundColor(.secondary)
            }
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

//preview
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
    }
}
