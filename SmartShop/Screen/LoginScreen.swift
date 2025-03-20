//
//  LoginScreen.swift
//  SmartShop
//
//  Created by umtlab03im07 on 20/3/25.
//

import SwiftUI

struct LoginScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var isLoading: Bool = false
    
    @AppStorage("userId") private var userId: Int?
    
    @State private var showRegistration = false // Khai báo biến showRegistration
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func login() async {
        isLoading = true
        
        do {
            let response = try await authenticationController.login(username: username, password: password)
            
            guard let token = response.token,
                  let userId = response.userId, response.success else {
                message = response.message ?? "Request cannot be completed."
                return
            }
            
            // Set the token in Keychain
            Keychain.set(token, forKey: "jwttoken")
            
            // Set userId in user defaults
            self.userId = userId
            
        } catch {
            message = "Failed to decode response: \(error.localizedDescription)"
        }
        
        isLoading = false
        
        username = ""
        password = ""
    }
    
    var body: some View {
        Form {
            // Header section với biểu tượng
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.circle")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.vertical, 20)
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
            // Mục thông tin đăng nhập
            Section(header: Text("THÔNG TIN ĐĂNG NHẬP")) {
                HStack {
                    Image(systemName: "person")
                        .foregroundColor(.gray)
                        .frame(width: 25)
                    
                    TextField("Username", text: $username)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .padding(.vertical, 10)
                }
                
                HStack {
                    Image(systemName: "lock")
                        .foregroundColor(.gray)
                        .frame(width: 25)
                    
                    SecureField("Password", text: $password)
                        .padding(.vertical, 10)
                }
            }
            
            // Nút đăng nhập
            Section {
                Button {
                    Task {
                        await login()
                    }
                } label: {
                    HStack {
                        Spacer()
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Đăng nhập")
                                .fontWeight(.semibold)
                                .foregroundColor(.white)
                        }
                        Spacer()
                    }
                    .padding()
                    .background(isFormValid ? Color.blue : Color.gray.opacity(0.5))
                    .cornerRadius(10)
                }
                .disabled(!isFormValid || isLoading)
                .buttonStyle(PlainButtonStyle())
                .listRowBackground(Color.clear)
            }
            
            // Phần hiển thị lỗi
            if !message.isEmpty {
                Section {
                    HStack {
                        Image(systemName: "exclamationmark.triangle")
                            .foregroundColor(.red)
                        
                        Text(message)
                            .foregroundColor(.red)
                    }
                    .padding()
                    .background(Color.red.opacity(0.1))
                    .cornerRadius(10)
                }
                .listRowBackground(Color.clear)
            }
            
            // Liên kết đăng ký
            Section {
                HStack {
                    Spacer()
                    Text("Chưa có tài khoản?")
                        .foregroundColor(.gray)
                    Button("Đăng ký") {
                        showRegistration = true
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
        }
        .fullScreenCover(isPresented: $showRegistration) {
            RegistrationScreen()
        }
        .navigationDestination(item: $userId, destination: { _ in
            Text("Home Screen")
        })
        
        .navigationTitle("Đăng nhập")
        .scrollContentBackground(.hidden)
        .background(Color(UIColor.systemGroupedBackground))
    }
}


#Preview {
    NavigationStack {
        LoginScreen()
    }.environment(\.authenticationController, .development)
}

