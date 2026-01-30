# 🚀 Quick Start - Projekt TBO

## 1️⃣ Setup (5 minut)
```bash
# Clone repo
git clone git@github.com:Michal2390/TBO-project.git
cd TBO-project

# Otwórz w Xcode
open TBO-Lab4.xcodeproj
```

### ⚠️ WAŻNE: Dodaj pliki do projektu

W Xcode:
1. Kliknij prawym na folder `TBO-Lab4`
2. **Add Files to TBO-Lab4...**
3. Zaznacz foldery: `Models/` i `ViewModels/`
4. ✅ Target: TBO-Lab4
5. Cmd+B (build) - powinno się skompilować

---

## 2️⃣ Uruchom lokalnie (2 minuty)

```bash
# Build
xcodebuild clean build -project TBO-Lab4.xcodeproj -scheme TBO-Lab4

# Testy
xcodebuild test -project TBO-Lab4.xcodeproj -scheme TBO-Lab4 -destination 'platform=iOS Simulator,name=iPhone 15'
```

---

## 3️⃣ Zainstaluj narzędzia bezpieczeństwa

```bash
# SwiftLint
brew install swiftlint

# Semgrep
pip3 install semgrep

# Test
swiftlint lint
semgrep --config .semgrep.yml .
```

---

## 4️⃣ Push i zobacz GitHub Actions

```bash
git add .
git commit -m "feat: Setup projektu TBO"
git push origin main
```

Idź do: https://github.com/Michal2390/TBO-project/actions

✅ Wszystkie joby powinny przejść!

---

## 5️⃣ Zadanie 2 - Dodaj podatności

```bash
# Utwórz gałąź
git checkout -b vulnerability-injection

# Utwórz folder Services
mkdir -p TBO-Lab4/Services
```

**Utwórz plik `TBO-Lab4/Services/APIClient.swift`:**

```swift
import Foundation

class APIClient {
    // PODATNOŚĆ: Hardcoded API key
    private let apiKey = "sk_live_FAKE_DEMO_KEY"
    
    func fetchData() {
        let url = "https://api.example.com/data?key=\(apiKey)"
        print(url)
    }
}
```

**Utwórz plik `TBO-Lab4/Services/DatabaseManager.swift`:**

```swift
import Foundation

class DatabaseManager {
    // PODATNOŚĆ: HTTP zamiast HTTPS
    let serverURL = "http://insecure.example.com"
    
    // PODATNOŚĆ: SQL Injection
    func login(username: String) -> String {
        return "SELECT * FROM users WHERE name='\(username)'"
    }
}
```

**Dodaj do Xcode:**
1. Prawy klik na `TBO-Lab4` → Add Files
2. Zaznacz folder `Services/`
3. ✅ Target: TBO-Lab4

**Push:**

```bash
git add TBO-Lab4/Services/
git commit -m "test: Podatności dla weryfikacji CI/CD"
git push origin vulnerability-injection
```

**Sprawdź Actions:**
https://github.com/Michal2390/TBO-project/actions

❌ Pipeline powinien FAIL-nąć!

---

## ✅ Gotowe!

Masz kompletny projekt TBO:
- ✅ Aplikacja iOS
- ✅ CI/CD z testami bezpieczeństwa
- ✅ SAST + SCA + DAST
- ✅ Weryfikacja na gałęzi z podatnościami

**Do oddania:**
1. Link do repo
2. Link do failed jobu (vulnerability-injection)
3. Nadaj dostęp @siewer

**Dokumentacja:** Czytaj `README.md` i `ZADANIE_2_INSTRUKCJE.md`
