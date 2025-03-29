//Scenarios Based Learning SafetyView
import SwiftUI

struct Situation: Identifiable {
    let id: Int
    let scenario: String
    let options: [String]
    let correctAnswer: Int 
    let explanation: String
}

struct Constants {
    static let cornerRadius: CGFloat = 15
    static let buttonHeight: CGFloat = 50
    static let popupWidth: CGFloat = 320
    static let popupHeight: CGFloat = 420
    static let shadowRadius: CGFloat = 12
    
    static let scenarioPadding: CGFloat = 40
}

func createSituation(id: Int, scenario: String, originalOptions: [String], originalCorrectIndex: Int, explanation: String) -> Situation {
   
    let shuffledOptions = originalOptions.shuffled()
 
    let correctOption = originalOptions[originalCorrectIndex]
    guard let correctAnswer = shuffledOptions.firstIndex(of: correctOption) else {
        fatalError("Correct option not found in shuffled options")
    }
    
    return Situation(
        id: id,
        scenario: scenario,
        options: shuffledOptions,
        correctAnswer: correctAnswer,
        explanation: explanation
    )
}

struct SafetyView: View {
    @State private var currentPage = 0
    @State private var selectedAnswer: Int?
    @State private var showExplanation = false
    @State private var userAnswers: [Int?] = Array(repeating: nil, count: 10)
    @State private var showResults = false
  
    let situations: [Situation] = [
        createSituation(
            id: 1,
            scenario: "If you notice someone following you on a dark street, how do you determine if it’s a coincidence or a threat?",
            originalOptions: ["Ignore them and keep walking", "Change direction and observe their behavior"],
            originalCorrectIndex: 1, 
            explanation: "Changing direction helps you assess if the person is genuinely following you or if it’s a coincidence."
        ),
        createSituation(
            id: 2,
            scenario: "If you were falsely accused of a crime with strong circumstantial evidence against you, how would you defend yourself?",
            originalOptions: ["Panic and give up", "Gather evidence and seek legal representation"],
            originalCorrectIndex: 1, 
            explanation: "Gathering evidence and seeking legal representation are key to defending yourself effectively."
        ),
        createSituation(
            id: 3,
            scenario: "If you suddenly lost all your money and had to survive with nothing, what’s your first move?",
            originalOptions: ["Wait for help", "Secure basic needs like shelter and food"],
            originalCorrectIndex: 1, 
            explanation: "Securing basic needs like shelter and food is the first step to surviving in such a situation."
        ),
        createSituation(
            id: 4,
            scenario: "How do you determine whether someone is genuinely kind or just pretending for personal gain?",
            originalOptions: ["Judge based on first impressions", "Observe their actions over time"],
            originalCorrectIndex: 1, 
            explanation: "Observing someone’s actions over time helps determine their true intentions."
        ),
        createSituation(
            id: 5,
            scenario: "If someone you trust deeply tells you a lie, how do you confront them without destroying the relationship?",
            originalOptions: ["Confront them aggressively", "Understand their reasons and address the issue calmly"],
            originalCorrectIndex: 1, 
            explanation: "Addressing the issue calmly helps maintain trust while resolving the conflict."
        ),
        createSituation(
            id: 6,
            scenario: "How would you solve a major argument between two close friends without taking sides?",
            originalOptions: ["Avoid getting involved", "Mediate and help them see each other’s perspective"],
            originalCorrectIndex: 1, 
            explanation: "Helping both parties see each other’s perspective is key to resolving conflicts."
        ),
        createSituation(
            id: 7,
            scenario: "If you were locked in a room with no obvious exits, what steps would you take to escape?",
            originalOptions: ["Panic and give up", "Search for hidden exits or clues"],
            originalCorrectIndex: 1, 
            explanation: "Searching for hidden exits or clues is the logical first step to escape."
        ),
        createSituation(
            id: 8,
            scenario: "If a stranger collapses on the street, what’s the most effective way to help while ensuring you don’t cause harm?",
            originalOptions: ["Move them immediately", "Check for breathing and call emergency services"],
            originalCorrectIndex: 1, 
            explanation: "Checking for breathing and calling emergency services ensures you don’t cause further harm."
        ),
        createSituation(
            id: 9,
            scenario: "If you were given $1,000 and had to double it in 24 hours legally, what would you do?",
            originalOptions: ["Spend it on lottery tickets", "Invest in quick resale opportunities"],
            originalCorrectIndex: 1, 
            explanation: "Investing in quick resale opportunities is a practical way to double your money."
        ),
        createSituation(
            id: 10,
            scenario: "How do you determine if someone is lying when they tell you a story?",
            originalOptions: ["Believe them without question", "Look for inconsistencies in their story"],
            originalCorrectIndex: 1, 
            explanation: "Looking for inconsistencies in their story helps determine if they’re lying."
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

//Situation View
struct SituationView: View {
    let situation: Situation
    @Binding var selectedAnswer: Int?
    @Binding var showExplanation: Bool
    let progress: Double
    @Binding var userAnswers: [Int?]
    let continueAction: () -> Void
    
    @State private var showPopup = true
    
    var body: some View {
        ZStack {
            VStack {
                ProgressBar(value: progress)
                    .padding(.top)
                
                ScrollView {
                    VStack(spacing: 30) {
                        Text(situation.scenario)
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(Color(.label))
                            .padding(.top, Constants.scenarioPadding)
                        
                        VStack(spacing: 15) {
                            ForEach(Array(situation.options.enumerated()), id: \.offset) { index, option in
                                Button {
                                    withAnimation {
                                        selectedAnswer = index
                                        showExplanation = true
                                        userAnswers[situation.id - 1] = index
                                    }
                                } label: {
                                    AnswerOption(
                                        text: option,
                                        isSelected: selectedAnswer == index,
                                        isCorrect: situation.correctAnswer == index,
                                        showValidation: showExplanation
                                    )
                                }
                                .disabled(showExplanation)
                            }
                        }
                        
                        if showExplanation {
                            ExplanationView(
                                explanation: situation.explanation,
                                correctOption: situation.options[situation.correctAnswer],
                                isCorrect: selectedAnswer == situation.correctAnswer,
                                continueAction: continueAction
                            )
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("Where Decisions Shape Your Future")
            .navigationBarTitleDisplayMode(.inline)
            .background(Color(.systemBackground).ignoresSafeArea())
            .foregroundColor(Color(.label))
            
            if showPopup {
                WelcomePopup(isVisible: $showPopup)
            }
        }
    }
}

//Answer Option
struct AnswerOption: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showValidation: Bool
    
    var body: some View {
        HStack {
            Text(text)
                .foregroundColor(showValidation ? (isCorrect ? .white : .white) : Color(.label))
                .padding()
                .frame(maxWidth: .infinity, alignment: .leading)
            
            if showValidation {
                Image(systemName: isCorrect ? "checkmark.circle.fill" : "xmark.circle.fill")
                    .foregroundColor(isCorrect ? .green : .red)
                    .padding()
            }
        }
        .background(
            showValidation ?
            (isCorrect ? Color.green.opacity(0.2) : Color.red.opacity(0.2)) :
                (isSelected ? Color.blue.opacity(0.2) : Color.gray.opacity(0.2))
        )
        .cornerRadius(15)
        .overlay(
            RoundedRectangle(cornerRadius: 15)
                .stroke(showValidation ?
                        (isCorrect ? Color.green : Color.red) :
                            (isSelected ? Color.blue : Color.gray), lineWidth: 2)
        )
    }
}

//Explanation View
struct ExplanationView: View {
    let explanation: String
    let correctOption: String
    let isCorrect: Bool
    let continueAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text(isCorrect ? "Correct!" : " Incorrect")
                .font(.title3.bold())
                .foregroundColor(isCorrect ? .green : .red)
            
            Text(isCorrect ? 
                 "Great choice! \(explanation)" : 
                    "Better luck next time. \(explanation)")
            .multilineTextAlignment(.center)
            .foregroundColor(Color(.secondaryLabel))
            
            Text("Correct answer: \(correctOption)")
                .font(.subheadline.bold())
                .foregroundColor(.green)
            
            Button(action: continueAction) {
                Text("Continue")
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
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(15)
    }
}

//Results View
struct ResultsView: View {
    let situations: [Situation]
    let userAnswers: [Int?]
    let resetAction: () -> Void
    
    var totalCorrectAnswers: Int {
        userAnswers.enumerated().reduce(0) { result, answer in
            let (index, userAnswer) = answer
            return result + (userAnswer == situations[index].correctAnswer ? 1 : 0)
        }
    }
    
    var allCorrect: Bool {
        totalCorrectAnswers == situations.count
    }
    
    var body: some View {
        VStack {
            Text("Results")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color(.label))
                .padding(.top, 40)
            
            if allCorrect {
                Text("Congratulations! 🎉")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.green)
                    .padding(.bottom, 8)
                
                Text("You answered all \(situations.count) questions correctly!")
                    .font(.title2)
                    .foregroundColor(Color(.label))
                    .multilineTextAlignment(.center)
                    .padding(.bottom, 20)
            } else {
                Text("You answered \(totalCorrectAnswers) out of \(situations.count) questions correctly.")
                    .font(.title2)
                    .foregroundColor(Color(.label))
                    .padding()
            }
            
            ScrollView {
                VStack(spacing: 20) {
                    ForEach(situations) { situation in
                        if userAnswers[situation.id - 1] != situation.correctAnswer {
                            IncorrectAnswerView(
                                situation: situation,
                                userAnswer: userAnswers[situation.id - 1]
                            )
                        }
                    }
                }
                .padding()
            }
            .frame(maxHeight: .infinity) 
        //restart button
            VStack(spacing: 20) {
                Button(action: resetAction) {
                    Text("Restart")
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
            }
            .padding(.horizontal, 30)
            .padding(.bottom, 20) 
        }
        .background(Color(.systemBackground).ignoresSafeArea())
        .foregroundColor(Color(.label))
    }
}
//Incorrect Answer View
struct IncorrectAnswerView: View {
    let situation: Situation
    let userAnswer: Int?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(situation.scenario)
                .font(.headline)
                .foregroundColor(Color(.label))
            
            if let userAnswer = userAnswer {
                Text("Your Answer: \(situation.options[userAnswer])")
                    .foregroundColor(.red)
            }
            
            Text("Correct Answer: \(situation.options[situation.correctAnswer])")
                .foregroundColor(.green)
            
            Text("Explanation: \(situation.explanation)")
                .foregroundColor(Color(.secondaryLabel))
        }
        .padding()
        .background(Color(.secondarySystemBackground))
        .cornerRadius(10)
    }
}

//Popup
struct WelcomePopup: View {
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
                    
                    //title
                    Text("Welcome to Scenario Based Learning")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.black)
                    
                    //description
                    Text("Learn essential safety protocols through interactive scenarios.")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.85))
                        .multilineTextAlignment(.leading)
                    
                    //header
                    Text("Why Scenario Based Learning?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .foregroundColor(.black)
                        .padding(.top, 8)
                    
                    //explanation
                    Text("Imagine facing a real life challenge. Would you know what to do? Scenario Based Learning helps you practice real situations, sharpen decision-making, and build confidence under pressure. Because when it matters most, being prepared is everything.")
                        .font(.body)
                        .foregroundColor(.black.opacity(0.85))
                        .multilineTextAlignment(.leading)
                    
                    //bulletpoints
                    VStack(alignment: .leading, spacing: 8) {
                        ForEach(0..<4, id: \.self) { index in
                            HStack(alignment: .top, spacing: 8) {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.black)
                                    .padding(.top, 6)
                                
                                Text(getBulletText(for: index))
                                    .font(.body)
                                    .foregroundColor(.black.opacity(0.85))
                                    .lineLimit(nil) 
                                    .multilineTextAlignment(.leading)
                                    .fixedSize(horizontal: false, vertical: true) 
                            }
                        }
                    }
                    .padding(.top, 8)
                    
                }
                .padding(24)
                .frame(maxWidth: Constants.popupWidth) 
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
        let bulletPoints = [
            "Step into real scenarios and learn by doing.",
            "Sharpen your decision making when it matters most.",
            "Gain the confidence to handle any crisis with ease.",
            "Grow through instant feedback and real world challenges."
        ]
        
        return index < bulletPoints.count ? bulletPoints[index] : ""
    }
}
//progress bar
struct ProgressBar: View {
    let value: Double
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: Constants.progressBarHeight)
                    .opacity(0.3)
                    .foregroundColor(Color.gray)
                
                Rectangle()
                    .frame(width: min(CGFloat(value) * geometry.size.width, geometry.size.width), height: Constants.progressBarHeight)
                    .foregroundColor(Color.blue)
                    .animation(.linear, value: value)
            }
        }
        .frame(height: Constants.progressBarHeight)
        .padding(.horizontal)
    }
}

//preview
struct SafetyView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            SafetyView()
        }
    }
}
