//
//  RegistrationScreen.swift
//  SmartShop
//
//  Created by umtlab03im07 on 19/3/25.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @Environment(\.authenticationController) private var authenticationController
    @Environment(\.dismiss) private var dismiss
    
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var message: String = ""
    @State private var isLoading: Bool = false
    
    private var isFormValid: Bool {
        !username.isEmptyOrWhitespace && !password.isEmptyOrWhitespace
    }
    
    private func register() async {
        isLoading = true
        
        do {
            let response = try await authenticationController.register(username: username, password: password)
            
            if response.success {
                dismiss()
            } else {
                message = response.message ?? ""
            }
            
        } catch {
            message = error.localizedDescription
        }
        
        isLoading = false
    }
    
    var body: some View {
        Form {
            // Header section với biểu tượng
            Section {
                HStack {
                    Spacer()
                    Image(systemName: "person.badge.plus")
                        .font(.system(size: 60))
                        .foregroundColor(.blue)
                        .padding(.vertical, 20)
                    Spacer()
                }
                .listRowBackground(Color.clear)
            }
            
            // Mục thông tin tài khoản
            Section(header: Text("THÔNG TIN TÀI KHOẢN")) {
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
            
            // Nút đăng ký
            Section {
                Button {
                    Task {
                        await register()
                    }
                } label: {
                    HStack {
                        Spacer()
                        if isLoading {
                            ProgressView()
                                .tint(.white)
                        } else {
                            Text("Đăng ký")
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
            
            // Liên kết đăng nhập
            Section {
                HStack {
                    Spacer()
                    Text("Đã có tài khoản?")
                        .foregroundColor(.gray)
                    Button("Đăng nhập") {
                        dismiss()
                    }
                    .foregroundColor(.blue)
                    .fontWeight(.semibold)
                    Spacer()
                }
            }
            .listRowBackground(Color.clear)
        }
        .navigationTitle("Đăng Ký")
        .scrollContentBackground(.hidden)
        .background(Color(UIColor.systemGroupedBackground))
    }
}

#Preview {
    NavigationStack {
        RegistrationScreen()
    }.environment(\.authenticationController, .development)
}


