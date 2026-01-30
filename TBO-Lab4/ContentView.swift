//
//  ContentView.swift
//  TBO-Lab4
//
//  Created by Michal Fereniec on 30/01/2026.
//

import SwiftUI

struct ContentView: View {
    @State private var selectedTab = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            LoginView()
                .tabItem {
                    Label("Login", systemImage: "person.circle")
                }
                .tag(0)
            
            DataView()
                .tabItem {
                    Label("Data", systemImage: "doc.text")
                }
                .tag(1)
            
            NetworkView()
                .tabItem {
                    Label("Network", systemImage: "network")
                }
                .tag(2)
            
            CryptoView()
                .tabItem {
                    Label("Crypto", systemImage: "lock.shield")
                }
                .tag(3)
        }
    }
}

// MARK: - Login View with Security Issues
struct LoginView: View {
    @State private var username = ""
    @State private var password = ""
    @State private var isLoggedIn = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Secure Login")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Username", text: $username)
                    .textFieldStyle(.roundedBorder)
                    .autocapitalization(.none)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(.roundedBorder)
                
                Button("Login") {
                    performLogin()
                }
                .buttonStyle(.borderedProminent)
                
                if isLoggedIn {
                    Text("✅ Logged in as: \(username)")
                        .foregroundColor(.green)
                }
            }
            .padding()
            .alert("Login Result", isPresented: $showAlert) {
                Button("OK") { }
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    // VULNERABILITY: Hardcoded credentials
    private func performLogin() {
        let adminUsername = "admin"
        let adminPassword = "password123" // Hardcoded password!
        
        // VULNERABILITY: SQL Injection-like string concatenation
        let query = "SELECT * FROM users WHERE username='\(username)' AND password='\(password)'"
        print("Executing query: \(query)")
        
        if username == adminUsername && password == adminPassword {
            isLoggedIn = true
            alertMessage = "Login successful!"
            
            // VULNERABILITY: Storing password in UserDefaults
            UserDefaults.standard.set(password, forKey: "user_password")
            UserDefaults.standard.set(username, forKey: "user_username")
        } else {
            isLoggedIn = false
            alertMessage = "Invalid credentials"
        }
        
        showAlert = true
    }
}

// MARK: - Data View with File Handling Issues
struct DataView: View {
    @State private var fileContent = ""
    @State private var userInput = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Data Manager")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Enter data to save", text: $userInput)
                    .textFieldStyle(.roundedBorder)
                
                Button("Save Data") {
                    saveData()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Load Data") {
                    loadData()
                }
                .buttonStyle(.bordered)
                
                ScrollView {
                    Text(fileContent)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
    
    private func saveData() {
        // VULNERABILITY: Insecure file permissions
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let filePath = "\(documentsDirectory)/sensitive_data.txt"
        
        // VULNERABILITY: No encryption for sensitive data
        do {
            try userInput.write(toFile: filePath, atomically: true, encoding: .utf8)
            fileContent = "Data saved to: \(filePath)"
        } catch {
            fileContent = "Error saving: \(error.localizedDescription)"
        }
    }
    
    private func loadData() {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        let filePath = "\(documentsDirectory)/sensitive_data.txt"
        
        // VULNERABILITY: No path validation
        do {
            let content = try String(contentsOfFile: filePath, encoding: .utf8)
            fileContent = content
        } catch {
            fileContent = "Error loading: \(error.localizedDescription)"
        }
    }
}

// MARK: - Network View with API Security Issues
struct NetworkView: View {
    @State private var apiResponse = ""
    @State private var apiKey = ""
    @State private var isLoading = false
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("API Client")
                    .font(.largeTitle)
                    .bold()
                
                TextField("API Key", text: $apiKey)
                    .textFieldStyle(.roundedBorder)
                
                Button("Fetch Data") {
                    fetchDataFromAPI()
                }
                .buttonStyle(.borderedProminent)
                .disabled(isLoading)
                
                if isLoading {
                    ProgressView()
                }
                
                ScrollView {
                    Text(apiResponse)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
    
    private func fetchDataFromAPI() {
        isLoading = true
        
        // VULNERABILITY: Hardcoded API key
        let defaultApiKey = "sk_test_51234567890abcdef"
        let keyToUse = apiKey.isEmpty ? defaultApiKey : apiKey
        
        // VULNERABILITY: HTTP instead of HTTPS
        let urlString = "http://api.example.com/data?key=\(keyToUse)"
        
        // VULNERABILITY: No certificate pinning
        guard let url = URL(string: urlString) else {
            apiResponse = "Invalid URL"
            isLoading = false
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        // VULNERABILITY: API key in URL parameters
        print("Making request to: \(urlString)")
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false
                
                if let error = error {
                    apiResponse = "Error: \(error.localizedDescription)"
                    return
                }
                
                if let data = data {
                    apiResponse = String(data: data, encoding: .utf8) ?? "No data"
                } else {
                    apiResponse = "No response data"
                }
            }
        }.resume()
    }
}

// MARK: - Crypto View with Weak Cryptography
struct CryptoView: View {
    @State private var plainText = ""
    @State private var encryptedText = ""
    @State private var decryptedText = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Crypto Tools")
                    .font(.largeTitle)
                    .bold()
                
                TextField("Enter text to encrypt", text: $plainText)
                    .textFieldStyle(.roundedBorder)
                
                Button("Encrypt") {
                    encryptData()
                }
                .buttonStyle(.borderedProminent)
                
                Button("Decrypt") {
                    decryptData()
                }
                .buttonStyle(.bordered)
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Encrypted:")
                        .font(.headline)
                    Text(encryptedText)
                        .padding()
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(8)
                    
                    Text("Decrypted:")
                        .font(.headline)
                    Text(decryptedText)
                        .padding()
                        .background(Color.green.opacity(0.1))
                        .cornerRadius(8)
                }
            }
            .padding()
        }
    }
    
    private func encryptData() {
        // VULNERABILITY: Weak encryption - simple XOR with fixed key
        let key: UInt8 = 42 // Weak key!
        let encrypted = plainText.map { char -> Character in
            let scalar = char.unicodeScalars.first!.value
            let encrypted = UInt8(scalar) ^ key
            return Character(UnicodeScalar(encrypted))
        }
        
        encryptedText = String(encrypted)
    }
    
    private func decryptData() {
        // VULNERABILITY: Same weak decryption
        let key: UInt8 = 42
        let decrypted = encryptedText.map { char -> Character in
            let scalar = char.unicodeScalars.first!.value
            let decrypted = UInt8(scalar) ^ key
            return Character(UnicodeScalar(decrypted))
        }
        
        decryptedText = String(decrypted)
    }
}

#Preview {
    ContentView()
}