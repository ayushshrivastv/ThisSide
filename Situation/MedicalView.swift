import SwiftUI

//Medical Scenarios
struct MedicalView: View {
    @State private var currentPage = 0
    @State private var selectedAnswer: Int?
    @State private var showExplanation = false
    @State private var userAnswers: [Int?] = Array(repeating: nil, count: 10)
    @State private var showResults = false
    
    //medical situations
    let situations: [Situation] = [
        Situation(
            id: 1,
            scenario: "A patient suddenly collapses in front of you and is unresponsive. What are the first three actions you take?",
            options: [
                "Check responsiveness, call for help, start CPR",
                "Give water, call for help, start CPR",
                "Check responsiveness, give sugar, call for help"
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "The correct steps are: 1. Check responsiveness (tap and shout). 2. Call for emergency help. 3. Start CPR if no pulse or breathing."
        ),
        Situation(
            id: 2,
            scenario: "A child accidentally drinks a household cleaning product. What immediate steps should you take before medical help arrives?",
            options: [
                "Induce vomiting, give water, call poison control",
                "Do not induce vomiting, check the label, give small sips of water",
                "Give milk, induce vomiting, call poison control"
            ].shuffled(),
            correctAnswer: 1, //correct answer is the second option
            explanation: "DO NOT induce vomiting. Check the product label and give small sips of water if advised by poison control."
        ),
        Situation(
            id: 3,
            scenario: "A patient in the ER is breathing rapidly, sweating, and has chest pain. How do you differentiate a panic attack from a heart attack?",
            options: [
                "Panic Attack: Sudden, lasts 10-30 minutes, tingling sensations. Heart Attack: Chest pain radiates, nausea, abnormal ECG.",
                "Panic Attack: Chest pain radiates, nausea. Heart Attack: Sudden, lasts 10-30 minutes, tingling sensations.",
                "Panic Attack: Abnormal ECG. Heart Attack: Tingling sensations, no abnormal ECG."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Panic Attack: Sudden, lasts 10-30 minutes, tingling sensations, no abnormal ECG. Heart Attack: Chest pain may radiate, nausea, abnormal ECG."
        ),
        Situation(
            id: 4,
            scenario: "A diabetic patient is found unconscious. Do you give them sugar or insulin? Why?",
            options: [
                "Give sugar—hypoglycemia is more dangerous and common.",
                "Give insulin—hyperglycemia is more dangerous.",
                "Wait for medical help—do not give anything."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Always give sugar (glucose)—hypoglycemia (low blood sugar) is more dangerous and common than hyperglycemia."
        ),
        Situation(
            id: 5,
            scenario: "A person gets a deep cut, and the wound is heavily bleeding. What’s the correct way to stop it?",
            options: [
                "Apply direct pressure, elevate the limb, do not remove embedded objects.",
                "Apply ice, elevate the limb, remove embedded objects.",
                "Apply a tourniquet, do not elevate the limb."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Apply direct pressure with a clean cloth, elevate the limb, and DO NOT remove deeply embedded objects."
        ),
        Situation(
            id: 6,
            scenario: "A person is having a seizure in a public place. What should you do—and what should you avoid?",
            options: [
                "Do not restrain them, move objects away, time the seizure.",
                "Restrain them, put objects in their mouth, call for help.",
                "Give water, move objects away, do not time the seizure."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "DO NOT restrain them or put objects in their mouth. Move objects away and time the seizure—if over 5 minutes, call emergency services."
        ),
        Situation(
            id: 7,
            scenario: "A person complains of a severe headache, stiff neck, and sensitivity to light. What life-threatening condition should you suspect?",
            options: [
                "Meningitis—seek emergency care immediately.",
                "Migraine—give painkillers and rest.",
                "Sinus infection—use a decongestant."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Suspect meningitis—a serious infection requiring urgent treatment. Delayed treatment can be fatal."
        ),
        Situation(
            id: 8,
            scenario: "A patient has a burn injury from boiling water. How do you properly treat the burn?",
            options: [
                "Cool the burn under running water, cover with a clean bandage, do not pop blisters.",
                "Apply ice, cover with a clean bandage, pop blisters.",
                "Apply butter, cover with a clean bandage, do not pop blisters."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Cool the burn under running water for 10-20 minutes, cover with a clean, non-stick bandage, and DO NOT pop blisters."
        ),
        Situation(
            id: 9,
            scenario: "A hiker is bitten by a snake in a remote area. What’s the safest way to handle the situation?",
            options: [
                "Stay calm, limit movement, keep the bite at or below heart level.",
                "Suck out venom, apply a tourniquet, keep the bite elevated.",
                "Run for help, apply ice, keep the bite elevated."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Stay calm, limit movement, and keep the bite at or below heart level. DO NOT suck out venom or apply a tourniquet."
        ),
        Situation(
            id: 10,
            scenario: "A patient with a head injury becomes sleepy and confused hours after the accident. What should you do?",
            options: [
                "Seek emergency medical attention immediately.",
                "Let them sleep and monitor for changes.",
                "Give painkillers and wait for symptoms to improve."
            ].shuffled(),
            correctAnswer: 0, //correct answer is the first option
            explanation: "Seek emergency medical attention immediately—symptoms suggest a possible brain hemorrhage (subdural hematoma)."
        )
    ]
    
    var body: some View {
        if showResults {
            ResultsView(
                situations: situations,
                userAnswers: userAnswers,
                resetAction: resetQuiz
            )
        } else {
            SituationView(
                situation: situations[currentPage],
                selectedAnswer: $selectedAnswer,
                showExplanation: $showExplanation,
                progress: Double(currentPage) / Double(situations.count),
                userAnswers: $userAnswers,
                continueAction: advancePage
            )
        }
    }
    //resultpage
    private func resetQuiz() {
        currentPage = 0
        selectedAnswer = nil
        showExplanation = false
        userAnswers = Array(repeating: nil, count: situations.count)
        showResults = false
    }
    
    private func advancePage() {
        if currentPage < situations.count - 1 {
            currentPage += 1
            selectedAnswer = nil
            showExplanation = false
        } else {
            showResults = true
        }
    }
}
//popup 
struct MedicalPopup: View {
    @Binding var isVisible: Bool
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        if isVisible {
            ZStack(alignment: .top) {
                
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        isVisible = false
                    }

                VStack(alignment: .leading, spacing: 16) {
                    //header
                    Text("Welcome to Medical Training")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    //message
                    Text("Learn essential medical protocols through interactive scenarios.")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.85))
                        .multilineTextAlignment(.leading)
                    
                    Text("Why Medical Training?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.top, 8)
                    
                    Text("Medical training helps you practice real-life emergency scenarios, improve decision-making, and build confidence in handling medical emergencies.")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.85))
                        .multilineTextAlignment(.leading)
                    
                    //bulletpoints popup
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<4, id: \.self) { index in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "cross.case.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.blue)
                                    .padding(.top, 6)
                                Text(getBulletText(for: index))
                                    .font(.body)
                                    .foregroundColor(.black.opacity(0.85))
                                    .lineLimit(nil)
                                    .multilineTextAlignment(.leading)
                            }
                        }
                    }
                    .padding(.top, 8)
                    
                    Button(action: {
                        withAnimation {
                            isVisible = false
                        }
                    }) {
                        Text("Got It")
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                    .padding(.top, 16)
                }
                .padding(24)
                .frame(width: Constants.popupWidth, height: Constants.popupHeight)
                .background(Color.white)
                .cornerRadius(Constants.cornerRadius)
                .shadow(radius: Constants.shadowRadius)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.width) > 100 || abs(value.translation.height) > 100 {
                                isVisible = false
                            } else {
                                dragOffset = .zero
                            }
                        }
                )
                .padding(.top, 50)
            }
            .transition(.identity)
            .animation(.none, value: isVisible)
        }
    }
    
    func getBulletText(for index: Int) -> String {
        switch index {
        case 0: return "Practice real-life medical emergencies in a safe environment."
        case 1: return "Improve decision-making under pressure."
        case 2: return "Build confidence to handle medical emergencies effectively."
        case 3: return "Receive instant feedback to enhance learning."
        default: return ""
        }
    }
}

//Preview
struct MedicalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            MedicalView()
        }
    }
}
