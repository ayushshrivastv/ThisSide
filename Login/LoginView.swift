//LoginPage, As per the current requirements, if you click "Login with Apple" it will bypass the login process.

//LoginPage
import SwiftUI
import AuthenticationServices

//Please use GroupCode "NY8282" to enter demo SpaceView.swift page

struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isPasswordVisible: Bool = false
    @State private var showError: Bool = false
    @State private var errorMessage: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var showMessage: Bool = false
    @State private var showPopup: Bool = true
    
    //demo id for testing purpose
    private let demoEmail = "hello@thisside.com"
    private let demoPassword = "welcome"
    //login process
    var body: some View {
        NavigationStack {
            ZStack {
                VStack(spacing: 10) {
                    
                    Text("Sign In")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 10)
                    
                    //email field
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Email Address")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        TextField("Enter your email", text: $email)
                            .font(.system(size: 18))
                            .padding()
                            .background(Color(white: 0.1))
                            .cornerRadius(8)
                            .foregroundColor(.white)
                            .keyboardType(.emailAddress)
                            .textInputAutocapitalization(.never)
                    }
                    .padding(.horizontal, 30)
                    
                    //password 
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Password")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.white)
                        
                        HStack {
                            if isPasswordVisible {
                                TextField("Enter your password", text: $password)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            } else {
                                SecureField("Enter your password", text: $password)
                                    .font(.system(size: 18))
                                    .foregroundColor(.white)
                            }
                            
                            Button(action: {
                                isPasswordVisible.toggle()
                            }) {
                                Image(systemName: isPasswordVisible ? "eye" : "eye.slash")
                                    .foregroundColor(.gray)
                            }
                        }
                        .padding()
                        .background(Color(white: 0.1))
                        .cornerRadius(8)
                    }
                    .padding(.horizontal, 30)
                    
                    //login buttons
                    Button(action: {
                        if !email.isEmpty && !password.isEmpty {
                            loginWithEmail(email: email, password: password)
                        } else {
                            errorMessage = "Please fill in all fields."
                            showError = true
                        }
                    }) {
                        Text("LogIn")
                            .frame(maxWidth: .infinity)
                            .padding()
                            .font(.system(size: 18, weight: .bold))
                            .foregroundColor(.white)
                            .background(Color.green)
                            .cornerRadius(25)
                    }
                    .padding(.horizontal, 30)
                    .padding(.top, 20)
                    
                    //not connected yet 
                    Button(action: {
                        print("Forgot password tapped")
                    }) {
                        Text("Forgot your password?")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                    }
                    
                    Spacer()
                    
                    //backend server not in use presently to deploy apple login..
                    VStack(spacing: 15) {
                        
                        Button(action: {
                            handleBypassSignIn()
                        }) {
                            HStack {
                                Image(systemName: "applelogo")
                                    .font(.system(size: 20, weight: .bold))
                                Text("Log in with Apple")
                                    .font(.system(size: 18, weight: .medium))
                            }
                            .frame(maxWidth: .infinity)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.black)
                            .cornerRadius(25)
                            .overlay(
                                RoundedRectangle(cornerRadius: 25)
                                    .stroke(Color.white.opacity(0.7), lineWidth: 1)
                            )
                        }
                        .padding(.horizontal, 30)
                        
                        //for now we can bypass the login process 
                        Button(action: {
                            handleBypassSignIn()
                        }) {
                            Text("Continue with phone number")
                                .font(.system(size: 18, weight: .medium))
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 25)
                                        .stroke(Color.white.opacity(0.7), lineWidth: 1)
                                )
                        }
                        .padding(.horizontal, 30)
                        
                        if showMessage {
                            Text("You are now signed in!")
                                .padding()
                                .foregroundColor(.green)
                                .font(.headline)
                                .transition(.opacity)
                        }
                    }
                    .padding(.top, 20)
                    
                    Spacer()
                    
                    //just for interface later we can create signup process
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                            .foregroundColor(.white.opacity(0.7))
                        Button(action: {
                            print("Sign up tapped")
                        }) {
                            Text("Sign up for ThisSide")
                                .font(.system(size: 14))
                                .foregroundColor(.white)
                                .underline()
                        }
                    }
                    .padding(.bottom, 30)
                }
                .background(Color.black.edgesIgnoringSafeArea(.all))
                .alert(isPresented: $showError) {
                    Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
                }
                .navigationDestination(isPresented: $isLoggedIn) {
                    UserDataView()
                }
                
                CustomPopup(isVisible: $showPopup)
            }
        }
    }
    
    //login
    func loginWithEmail(email: String, password: String) {
        //check against demo credentials
        if email == demoEmail && password == demoPassword {
            isLoggedIn = true
        } else {
            errorMessage = "Invalid email or password"
            showError = true
        }
    }
    //login bypass have to remove it after adding backend
    func handleBypassSignIn() {
        withAnimation {
            showMessage = true
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            withAnimation {
                showMessage = false
                isLoggedIn = true
            }
        }
    }
}
//preview
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
            .preferredColorScheme(.dark)
    }
}
