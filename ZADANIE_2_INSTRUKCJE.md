# 🔬 ZADANIE 2 - Weryfikacja CI/CD Security

## Cel:
Dodać 2 podatności bezpieczeństwa i pokazać, że pipeline je wykrywa i blokuje deployment.

---

## Krok 1: Utwórz gałąź testową
```bash
git checkout -b vulnerability-injection
```

---

## Krok 2: Dodaj Podatność #1 - Hardcoded API Key

Utwórz nowy plik: `TBO-Lab4/Services/APIClient.swift`

```swift
//
//  APIClient.swift
//  TBO-Lab4
//
//  PODATNOŚĆ: Zahardkodowany klucz API
//

import Foundation

class APIClient {
    // 🔴 PODATNOŚĆ 1: Hardcoded API Key (CWE-798)
    private let apiKey = "sk_live_FAKE_KEY_FOR_DEMO_12345"
    private let baseURL = "https://api.example.com"
    
    func fetchData() async throws -> Data {
        // 🔴 PODATNOŚĆ: API key w URL
        let urlString = "\(baseURL)/data?api_key=\(apiKey)"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        return data
    }
}
```

**Dlaczego to jest podatność:**
- Klucz API jest zahardkodowany w kodzie źródłowym
- Każdy kto ma dostęp do kodu może go wykraść
- CWE-798: Use of Hard-coded Credentials
- OWASP: A07:2021 - Identification and Authentication Failures

**Co zostanie wykryte:**
- SwiftLint custom rule: `hardcoded_api_key`
- Semgrep: pattern `api_key = "..."`

---

## Krok 3: Dodaj Podatność #2 - Insecure HTTP + SQL Injection

Utwórz nowy plik: `TBO-Lab4/Services/DatabaseManager.swift`

```swift
//
//  DatabaseManager.swift
//  TBO-Lab4
//
//  PODATNOŚĆ: HTTP + SQL Injection
//

import Foundation

class DatabaseManager {
    
    // 🔴 PODATNOŚĆ 2a: Insecure HTTP (CWE-319)
    private let serverURL = "http://insecure-database.example.com/api"
    
    func login(username: String, password: String) -> Bool {
        // 🔴 PODATNOŚĆ 2b: SQL Injection (CWE-89)
        let query = "SELECT * FROM users WHERE username='\(username)' AND password='\(password)'"
        
        print("Executing query: \(query)")
        
        // Symulacja połączenia
        guard let url = URL(string: "\(serverURL)/login") else {
            return false
        }
        
        print("Connecting to: \(url.absoluteString)")
        return true
    }
    
    // 🔴 PODATNOŚĆ 2c: Storing password in UserDefaults (CWE-312)
    func saveCredentials(username: String, password: String) {
        UserDefaults.standard.set(password, forKey: "user_password")
        UserDefaults.standard.set(username, forKey: "user_username")
    }
}
```

**Dlaczego to są podatności:**

**2a) HTTP zamiast HTTPS:**
- Komunikacja nieszyfrowana
- Man-in-the-middle attacks
- CWE-319: Cleartext Transmission of Sensitive Information

**2b) SQL Injection:**
- Konkatenacja stringa w zapytaniu SQL
- Możliwość injection: `' OR '1'='1`
- CWE-89: Improper Neutralization of Special Elements (SQL Injection)

**2c) Password w UserDefaults:**
- Nieszyfrowane przechowywanie hasła
- CWE-312: Cleartext Storage of Sensitive Information

**Co zostanie wykryte:**
- SwiftLint: `http_url`, `sql_injection_risk`, `userdefaults_password`
- Semgrep: wszystkie 3 podatności

---

## Krok 4: Dodaj pliki do Xcode

1. Otwórz projekt w Xcode
2. Kliknij prawym na `TBO-Lab4` folder
3. **Add Files to TBO-Lab4**
4. Zaznacz folder `Services/` z oboma plikami
5. Target: `TBO-Lab4` ✅

---

## Krok 5: Commit i Push

```bash
# Dodaj nowe pliki
git add TBO-Lab4/Services/

# Commit z opisem
git commit -m "test: Dodanie podatności dla weryfikacji CI/CD (Zadanie 2)

Dodano 2 celowe podatności bezpieczeństwa:
1. Hardcoded API key (CWE-798)
2. HTTP + SQL Injection + Insecure storage (CWE-319, CWE-89, CWE-312)

Oczekiwany rezultat: Pipeline powinien FAIL-nąć"

# Push do gałęzi
git push origin vulnerability-injection
```

---

## Krok 6: Sprawdź GitHub Actions

1. Idź do: https://github.com/Michal2390/TBO-project/actions
2. Znajdź job dla gałęzi `vulnerability-injection`
3. **Oczekiwany rezultat:**

```
✅ Unit Tests - PASSED
❌ SAST SwiftLint - FAILED (3+ errors)
❌ SAST Semgrep - FAILED (3 critical)
⏹️  Build - SKIPPED (blocked)
```

---

## Krok 7: Screenshot i dokumentacja

### Zrób screenshoty:

1. **GitHub Actions Summary** - pokazujący że pipeline failuje
2. **SwiftLint Results** - pokazujący wykryte podatności
3. **Semgrep Results** - pokazujący wykryte podatności
4. **Job Logs** - pokazujące dokładne błędy

### Zapisz linki:

- Link do failed jobu: `https://github.com/Michal2390/TBO-project/actions/runs/XXXXX`
- Link do gałęzi: `https://github.com/Michal2390/TBO-project/tree/vulnerability-injection`

---

## Krok 8: Podsumowanie dla raportu

W README.md w sekcji "Zadanie 2" dodaj:

```markdown
## Zadanie 2 - Weryfikacja

### Wprowadzone podatności:

1. **Hardcoded API Key** (APIClient.swift)
   - CWE-798: Use of Hard-coded Credentials
   - Wykryte przez: SwiftLint + Semgrep
   
2. **Insecure HTTP + SQL Injection** (DatabaseManager.swift)
   - CWE-319: Cleartext Transmission
   - CWE-89: SQL Injection
   - CWE-312: Cleartext Storage
   - Wykryte przez: SwiftLint + Semgrep

### Rezultat:
❌ **Pipeline ZABLOKOWANY** - System bezpieczeństwa działa poprawnie!

### Linki:
- Gałąź: [vulnerability-injection](link)
- Failed Job: [GitHub Actions Run](link)
- Kod z podatnościami: [Diff](link)
```

---

## ✅ Checklist Zadania 2:

- [ ] Utworzono gałąź `vulnerability-injection`
- [ ] Dodano plik `APIClient.swift` z hardcoded API key
- [ ] Dodano plik `DatabaseManager.swift` z HTTP + SQL injection
- [ ] Pliki dodane do Xcode target
- [ ] Push do GitHub
- [ ] Pipeline wykrył podatności i FAIL-nął
- [ ] Zrobiono screenshoty
- [ ] Zaktualizowano README.md z linkami
- [ ] Przygotowano dokumentację dla prowadzącego

---

## 🎉 Gotowe!

Teraz masz kompletny projekt TBO z:
- ✅ Działającym CI/CD pipeline
- ✅ Testami bezpieczeństwa (SAST, SCA, DAST)
- ✅ Weryfikacją na gałęzi z podatnościami
- ✅ Pełną dokumentacją

**Do oddania:**
1. Link do repo: https://github.com/Michal2390/TBO-project
2. Link do failed jobu (Zadanie 2)
3. Dostęp dla @siewer ✅
