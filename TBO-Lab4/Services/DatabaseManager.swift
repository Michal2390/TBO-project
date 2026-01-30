//
//  DatabaseManager.swift
//  TBO-Lab4
//
//  🔴 PODATNOŚCI DLA ZADANIA 2 - Celowo wprowadzone podatności bezpieczeństwa
//

import Foundation

class DatabaseManager {
    
    // 🔴 PODATNOŚĆ #2a: Insecure HTTP Communication (CWE-319)
    // Używamy HTTP zamiast HTTPS - komunikacja nieszyfrowana
    // Atakujący może przechwycić dane (Man-in-the-Middle attack)
    private let serverURL = "http://insecure-database.example.com/api/v1"
    private let backupServer = "http://backup.example.com"
    
    // 🔴 PODATNOŚĆ #2b: SQL Injection (CWE-89)
    // String concatenation w SQL query - klasyczna podatność SQL Injection
    // Atakujący może wstrzyknąć: username = "admin' OR '1'='1"
    func loginUser(username: String, password: String) -> Bool {
        // BARDZO NIEBEZPIECZNE!
        let query = "SELECT * FROM users WHERE username='\(username)' AND password='\(password)'"
        
        print("🚨 Executing unsafe SQL query: \(query)")
        print("🚨 This is vulnerable to SQL Injection!")
        
        // Symulacja wykonania query
        executeQuery(query)
        
        return true
    }
    
    // 🔴 PODATNOŚĆ #2c: Storing Sensitive Data in UserDefaults (CWE-312)
    // Hasło w plain text w UserDefaults - kompletnie niezabezpieczone!
    // Każda aplikacja/proces może to odczytać
    func saveUserCredentials(username: String, password: String, apiToken: String) {
        print("🚨 Saving sensitive data in plain text to UserDefaults!")
        
        // BARDZO NIEBEZPIECZNE - hasła powinny być w Keychain!
        UserDefaults.standard.set(password, forKey: "user_password")
        UserDefaults.standard.set(username, forKey: "user_username")
        UserDefaults.standard.set(apiToken, forKey: "api_token")
        
        print("✅ Credentials 'saved' insecurely!")
    }
    
    // Dodatkowa podatność - HTTP connection
    func connectToServer() -> Bool {
        print("🚨 Connecting via HTTP (insecure): \(serverURL)")
        
        guard let url = URL(string: serverURL) else {
            return false
        }
        
        // HTTP communication - nieszyfrowane!
        print("🚨 Sending data over HTTP - can be intercepted!")
        print("URL: \(url.absoluteString)")
        
        return true
    }
    
    // Helper function - też z podatnościami
    private func executeQuery(_ query: String) {
        // Symulacja wykonania SQL query
        print("Executing: \(query)")
    }
    
    // 🔴 PODATNOŚĆ #2d: SQL Injection w search
    func searchUsers(searchTerm: String) -> [String] {
        // Kolejna SQL injection vulnerability
        let searchQuery = "SELECT name, email FROM users WHERE name LIKE '%\(searchTerm)%'"
        print("🚨 Search query vulnerable to SQL injection: \(searchQuery)")
        executeQuery(searchQuery)
        return []
    }
}