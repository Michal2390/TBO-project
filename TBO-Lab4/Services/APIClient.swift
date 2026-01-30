//
//  APIClient.swift
//  TBO-Lab4
//
//  🔴 PODATNOŚĆ DLA ZADANIA 2 - Celowo wprowadzone podatności bezpieczeństwa
//

import Foundation

class APIClient {
    
    // 🔴 PODATNOŚĆ #1: Hardcoded API Key (CWE-798: Use of Hard-coded Credentials)
    // To jest BARDZO niebezpieczne - klucz API jest zahardkodowany w kodzie źródłowym
    // Każdy kto ma dostęp do kodu może go wykraść i wykorzystać
    private let apiKey = "sk_live_REAL_VULNERABILITY_KEY_123456789"
    private let stripeKey = "pk_test_HARDCODED_STRIPE_KEY"
    private let baseURL = "https://api.example.com"
    
    // Dodatkowa podatność - API key w URL parameters
    func fetchUserData() async throws -> Data {
        // 🔴 PODATNOŚĆ: API key jest przekazywany w URL jako plaintext
        let urlString = "\(baseURL)/users?api_key=\(apiKey)"
        
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        print("🚨 Calling API with hardcoded key: \(urlString)")
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
    
    func processPayment(amount: Double) {
        // 🔴 PODATNOŚĆ: Zahardkodowany klucz Stripe
        print("Processing payment with Stripe key: \(stripeKey)")
    }
}