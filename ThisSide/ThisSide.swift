//ThisSide
//for now we can bypass the login process 

import SwiftUI

@main
struct MyApp: App {
    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding = false
    
    var body: some Scene {
        WindowGroup {
            if hasSeenOnboarding {
                LandingPageView()
            } else {
                OnboardingView()
            }
        }
    }
}

//LoginPage, As per the current requirements, if you click "Login with Apple" it will skip the login process.

//SpaceView.swift is the main file

//Designed the app with the layout of the iPhone 16 Pro in mind.

//The purpose of making this app is~ There are countless moments when you wish you could check in on a family member, know they’ve arrived safely at their destination. But, unfortunately, that’s not always as easy as it sounds. Communication can fall through the cracks, and busy lives can cause gaps in connection. That’s where ThisSide comes in.                                                                           I created ThisSide because I know what it’s like to feel that pang of worry when you can’t reach a loved one or the uncertainty when you don’t know where they are. I know the longing for reassurance that comes from just knowing they’re safe, or that they’re close, even if it’s just emotionally. That’s why this side exists to help you feel that peace. It’s not just about tracking; it’s about never feeling far apart from the ones you love, no matter where life leads you.

//For now, I'm using random location coordinates. To add realtime data, I need to connect the app to the backend to fetch the data. I’ve tried this, but I still need to improve the code with algorithms and a view pattern to properly display the mapview. I’ll get to work on this in the future!

//few things are optimised to operate without the internet for SSC, even the user’s location.

//this side is tailored for the iPhone 16 Pro layout. Everything looks and feels great on its screen size.

//I’ve used the character name and picture just to display mock data page, but I’ll change it later.

//Right now, ThisSide is just the beginning-a simple interface that shows my vision. The backend and complex algorithms are still coming, as I’m learning and working on them. Over the past few months, I’ve been focusing on frontend web development, which is where I’ve been able to design the initial interface. While I’m still learning and growing, I’m excited to keep building and bring this idea to life, making sure that no matter the distance, family is always just a tap away....
