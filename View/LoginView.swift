//
//  MessageView.swift
//  SyncChat
//
//  Created by RANA  on 4/8/24.
//

import SwiftUI
import Observation

@MainActor
struct LoginView: View {
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var UserError : String = ""
    @State private var isSignedIn : Bool = false
    
    @StateObject private var viewModel = UserViewModel()
    @EnvironmentObject private var profileViewModel : ProfileViewModel
    
    @Environment(\.colorScheme) private var isColor
    
    var body: some View {
        NavigationStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .foregroundStyle(LinearGradient(colors: [.blue, .blue.opacity(0.5), .clear, .clear , .clear , .clear], startPoint: .top, endPoint: .bottom))
                    .background(Color.clear)
                    .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, maxHeight : .infinity)
                    .blur(radius: 50)
                    .ignoresSafeArea()

                        VStack {
                           // Spacer()
                            
                            Image(systemName: "xmark.seal.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
                                .padding(.bottom, 50)
                            
                            Text("Login")
                                .font(.largeTitle)
                                .fontWeight(.bold)
                                .padding(.bottom, 80)
                                
                            
                            VStack(alignment: .leading, spacing: 0){
                                Text("E-Mail")
                                    .foregroundStyle(isColor == .light ? .gray : .white.opacity(0.9))
                                    .bold()
                                    .padding(.leading, 32)
                                
                                TextField("your email", text: $email)
                                    .textFieldStyle(.plain)
                                    .tint(.gray)
                                    //.frame(width: 400)
                                    .keyboardType(.emailAddress)
                                    .autocapitalization(.none)
                                    .padding()
                                    .background(Color(.systemGray6))
                                   // .cornerRadius(10)
                                    .padding(.horizontal)

                                Divider()
                                    .frame(width: 300)
                                    .padding(.leading, 32)
                                    .foregroundStyle(.gray)
                                
                                Text("Password")
                                    .foregroundStyle(isColor == .light ? .gray : .white.opacity(0.9))
                                    .bold()
                                    .padding(.leading, 32)
                                    .padding(.top, 20)
                                
                                SecureField("your password", text: $password)
                                    .padding()
                                    .background(Color(.systemGray6))
                                    .padding(.horizontal)
                                   // .padding(.top, 10)
                                
                                Divider()
                                    .frame(width: 300)
                                    .padding(.leading, 32)
                                    .foregroundStyle(.gray)
                                    
                                
                            }
                            .padding(.bottom, 50)
                            
                            if UserError != "" {
                                Text(UserError)
                                    .foregroundStyle(.red)
                            }
                            
                            Button(action: {
                                Task {
                                    try await viewModel.singIn(withEmail: email, password: password)
                                    UserError = viewModel.UserError ?? ""
                                    print(viewModel.currentUser?.email as Any)
                                    
                                    isSignedIn.toggle()

                                   
                                }
                                
                            }) {
                                Text("Login")
                                    .fontWeight(.semibold)
                                    .font(.title2)
                                    .frame(width: 280, height: 15)
                                    .padding()
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                    //.padding(.horizontal)
                                   // .padding(.top, 20)
                            }
                            //.frame(width: 400)
                            .buttonStyle(.borderedProminent)
                            .padding(.top)
                            
                            
                            //Spacer()
                            VStack(alignment: .leading){
                                Text("Don't have an account yet?")
                                    .foregroundStyle(isColor == .light ? .gray : .white.opacity(0.8))
                                NavigationLink {
                                    withAnimation {
                                        SignUpView()
                                    }
                                    
                                } label: {
                                    Text("Sign up")
                                        .foregroundStyle(isColor == .light ? .black : .green)
                                }

                            }
                            .padding(.leading, -120)
                            .padding(.top, 60)
                           
                                //.position(x: 20)
                        }

                    
            }
            .navigationBarBackButtonHidden(true)
            .background(.ultraThinMaterial)
            .navigationDestination(isPresented: $isSignedIn) {
                
                AllMessageView()
            }
            
            
        }
        
    }
}


#Preview{
    LoginView()
        .environmentObject(ProfileViewModel())
}
