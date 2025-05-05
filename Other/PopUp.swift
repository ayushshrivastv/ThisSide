//PopUps
import SwiftUI

struct CustomPopup: View {
    @Binding var isVisible: Bool
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        if isVisible {
            ZStack(alignment: .top) { 
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isVisible = true
                        }
                    }
 
                VStack {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome to ThisSide")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Just a quick note! To bypass the login process and get straight, tap “Login with Apple.” Enter the Group code NY8282, and you’re all set! Everything looks good on the iPhone 16 layout.")
                            .font(.body)
                            .foregroundColor(.black.opacity(0.85))
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20) 
                    .frame(minWidth: 250)  
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 12)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.height) > 100 {
                                withAnimation(.easeOut) {
                                    isVisible = false
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .padding(.top, 50) 
                .transition(.move(edge: .top)) 
                .animation(.spring(), value: isVisible)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
    }
}

struct CustomPopup_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopup(isVisible: .constant(true))
            .preferredColorScheme(.light)
    }
}

struct CustomPopup2: View {
    @Binding var isVisible: Bool
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        if isVisible {
            ZStack {
              
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isVisible = false
                        }
                    }
                
                VStack(spacing: 0) {
                    VStack {
                        HStack {
                            Text("Introducing ThisSide")
                                .font(.title3)
                                .fontWeight(.semibold)
                                .foregroundColor(.gray)
                                .padding(.bottom, 5)
                        }
                    }
                    .padding(.top, 10)
                   
                    ScrollView {
                        VStack(alignment: .leading, spacing: 12) {
                            Text("""
                            Hey there! I’m Ayush Srivastava, and I’m 20 years old. I’ve developed ThisSide, my submission for the Swift Student Challenge 2025. Currently, you’re holding the user manual. In this guide, I’ll explain how ThisSide works, from tracking your loved ones’ locations to enhancing your sense of security. However, before we begin, here are a few important things to keep in mind.
                            """)
                            .font(.body)
                            .foregroundColor(.black.opacity(0.85))
                            .multilineTextAlignment(.leading)
                            .padding(.horizontal, 20)
                           
                            VStack(alignment: .leading, spacing: 20) {
                               
                                ForEach(1...5, id: \.self) { index in
                                    HStack {
                                        ZStack {
                                            Circle()
                                                .fill(Color.black)
                                                .frame(width: 30, height: 30)
                                            Text("\(index)")
                                                .font(.body)
                                                .fontWeight(.bold)
                                                .foregroundColor(.white)
                                        }
                                        .padding(.trailing, 12) 
                                        
                                        Text(getBulletText(for: index))
                                            .font(.body)
                                            .foregroundColor(.black)
                                    }
                                    .padding(.horizontal, 20) 
                                }
                            }
                            .padding(.top, 20)
                            
                            
                            VStack(alignment: .leading, spacing: 20) {
                                Text("Chapter 1: What is ThisSide?")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                
                                Text("""
                                There are countless moments when you wish you could check in on a family member—just to know they’ve arrived safely. But life gets busy, communication slips through the cracks, and that simple reassurance isn’t always easy to get.
                                
                                That’s why I created ThisSide.
                                
                                I know what it’s like to feel that pang of worry when a loved one doesn’t respond, the uncertainty of not knowing where they are, and the longing for reassurance that they’re safe. ThisSide isn’t just about tracking locations—it’s about staying connected, feeling close, and giving peace of mind, no matter where life takes us.
                                """)
                                .font(.body)
                                .foregroundColor(.black.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                                
                                Text("Chapter 2: Ever wondered why ThisSide hasn’t been connected to the backend yet?")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                
                                Text("""
                                Right now, ThisSide is just the beginning-a simple interface that shows my vision. The backend and complex algorithms are still coming, as I’m learning and working on them. Over the past few months, I’ve been focusing on frontend web development, which is where I’ve been able to design the initial interface. While I’m still learning and growing, I’m excited to keep building and bring this idea to life, making sure that no matter the distance, family is always just a tap away..
                                """)
                                .font(.body)
                                .foregroundColor(.black.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                                
                                Text("Chapter 3: Eyes Wide Open—Seeing Health Through a Family Lens")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                
                                Text("""
                                Health is the reassurance that your loved ones are safe and sound. ThisSide connects you to their well-being, no matter the distance. Each update brings comfort, easing worries and offering peace of mind. It’s knowing you’re not alone, and that as family, you’re always looking out for each other.
                                
                                Vision feature is your lifeline. Emergencies can be terrifying, but with ThisSide’s Vision feature, you’re never alone. By learning from real-life experiences, you can make wiser, more confident decisions in moments that matter most. It turns fear into clarity, helping families act together with strength and wisdom when it counts.
                                """)
                                .font(.body)
                                .foregroundColor(.black.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                                
                                Text("Chapter 4: Safe Mode")
                                    .font(.headline)
                                    .foregroundColor(.black)
                                    .padding(.horizontal, 20)
                                
                                Text("""
                                The Safe Mode feature is designed to keep you secure when you’re in distress. Once activated, it automatically sends an alert to nearby users, notifying them of your situation and asking for assistance. This feature ensures you’re never alone in an emergency, connecting you with those around you who can help.
                                
                                Additionally, the Learn First Aid feature offers quick, easy-to-follow instructions for handling urgent emergencies, ensuring you’re prepared to assist in critical situations until help arrives.
                                """)
                                .font(.body)
                                .foregroundColor(.black.opacity(0.85))
                                .multilineTextAlignment(.leading)
                                .padding(.horizontal, 20)
                            }
                            .padding(.top, 20)
                        }
                        .padding(.top, 10)
                        .padding(.bottom, 20)
                    }
                    .frame(maxHeight: 500)
                }
                .frame(width: 340, height: 550)
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 12)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.height) > 200 { 
                                withAnimation(.easeOut) {
                                    isVisible = false
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .transition(.move(edge: .bottom))
                .animation(.spring(), value: isVisible)
            }
        }
    }
    
    func getBulletText(for index: Int) -> String {
        switch index {
        case 1:
            return "For now, the login page is just for show—and in a flash, it whisks you away to the next screen."
        case 2:
            return "Enter the Group code NY8282, and boom – you’re in! Enjoy!"
        case 3:
            return "This app is designed for an iPhone 16 Pro experience—enable notifications for SOS features."
        case 4: 
            return "For now this project runs on Swift Playground with a predefined dataset, so you can experience the app’s features without the need of backend integration and Internet Connection."
        case 5:
            return "Enjoy peace of mind knowing your loved ones are always within reach."
        default:
            return ""
        }
    }
}
    

struct CustomPopup2_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopup2(isVisible: .constant(true))
            .preferredColorScheme(.light)
    }
}

struct CustomPopup3: View {
    @Binding var isVisible: Bool
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        if isVisible {
            ZStack(alignment: .top) {
                
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isVisible = false
                        }
                    }
                VStack {
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Welcome to ThisSide")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Take a sneak peek at how ThisSide keeps you connected with the people who matter most. Sign in to explore more features.")
                            .font(.body)
                            .foregroundColor(.black.opacity(0.85))
                            .lineLimit(nil) 
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20)  
                    .frame(minWidth: 250)
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 12)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.height) > 100 {
                                withAnimation(.easeOut) {
                                    isVisible = false
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .padding(.top, 50)
                .transition(.move(edge: .top)) 
                .animation(.spring(), value: isVisible)
            }
        }
    }
}

struct CustomPopup3_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopup3(isVisible: .constant(true))
            .preferredColorScheme(.light)
    }
}

struct CustomPopup4: View {
    @Binding var isVisible: Bool
    @State private var dragOffset: CGSize = .zero
    
    var body: some View {
        if isVisible {
            ZStack(alignment: .top) {
               
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        withAnimation(.easeOut) {
                            isVisible = false
                        }
                    }
              
                VStack {
                  
                    VStack(alignment: .leading, spacing: 10) {
                        Text("ThisSide! Track. Connect. Belong.")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        
                        Text("Because knowing where your loved ones are makes every moment feel a little more special.")
                            .font(.body)
                            .foregroundColor(.black.opacity(0.85))
                            .lineLimit(nil)  
                            .multilineTextAlignment(.leading)
                    }
                    .padding(20)
                    .frame(minWidth: 250)
                }
                .background(Color.white)
                .cornerRadius(16)
                .shadow(radius: 12)
                .offset(dragOffset)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            dragOffset = value.translation
                        }
                        .onEnded { value in
                            if abs(value.translation.height) > 100 {
                                withAnimation(.easeOut) {
                                    isVisible = false
                                }
                            } else {
                                withAnimation(.spring()) {
                                    dragOffset = .zero
                                }
                            }
                        }
                )
                .padding(.top, 50) 
                .transition(.move(edge: .top)) 
                .animation(.spring(), value: isVisible)
            }
        }
    }
}

struct CustomPopup4_Previews: PreviewProvider {
    static var previews: some View {
        CustomPopup4(isVisible: .constant(true))
            .preferredColorScheme(.light)
    }
}


