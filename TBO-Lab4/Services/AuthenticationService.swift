//
//  AuthenticationService.swift
//  TBO-Lab4
//
//  🔴 DODATKOWE PODATNOŚCI - Bonus dla maksymalnej oceny
//

import Foundation

class AuthenticationService {
    
    // 🔴 PODATNOŚĆ #3: Więcej hardcoded secrets
    private let jwtSecret = "super_secret_jwt_key_123"
    private let adminPassword = "admin123"
    
    // 🔴 PODATNOŚĆ: Weak password validation
    func isPasswordStrong(_ password: String) -> Bool {
        // Bardzo słaba walidacja hasła!
        return password.count >= 3  // 3 znaki?! To żart!
    }
    
    // 🔴 PODATNOŚĆ: Plaintext password comparison
    func authenticateAdmin(password: String) -> Bool {
        // Porównywanie haseł w plain text
        if password == adminPassword {
            print("🚨 Admin authenticated with hardcoded password!")
            return true
        }
        return false
    }
    
    // 🔴 PODATNOŚĆ: No rate limiting info
    func attemptLogin(username: String, password: String, attempts: Int) {
        print("Login attempt #\(attempts) - no rate limiting!")
        // Brak ograniczenia liczby prób logowania
    }
}