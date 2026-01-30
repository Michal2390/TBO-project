# 📝 Instrukcje Setup Projektu TBO

## Krok 1: Dodaj nowe pliki do Xcode

Utworzono 2 nowe pliki które musisz dodać do projektu w Xcode:

### Pliki do dodania:
1. `TBO-Lab4/Models/Task.swift`
2. `TBO-Lab4/ViewModels/TaskManager.swift`

### Jak dodać:
1. Otwórz `TBO-Lab4.xcodeproj` w Xcode
2. Kliknij prawym na folder `TBO-Lab4` w nawigatorze
3. Wybierz **"Add Files to TBO-Lab4"**
4. Zaznacz folder `Models` (Task.swift)
5. Powtórz dla folderu `ViewModels` (TaskManager.swift)
6. Upewnij się że checkbox **"Copy items if needed"** jest NIE zaznaczony
7. Upewnij się że **"TBO-Lab4" target** jest zaznaczony

## Krok 2: Uruchom testy lokalnie```bash
# Test kompilacji
xcodebuild clean build -project TBO-Lab4.xcodeproj -scheme TBO-Lab4

# Uruchom testy jednostkowe
xcodebuild test -project TBO-Lab4.xcodeproj -scheme TBO-Lab4 -destination 'platform=iOS Simulator,name=iPhone 15'
```

## Krok 3: Zainstaluj narzędzia (jeśli jeszcze nie masz)

```bash
# SwiftLint
brew install swiftlint

# Semgrep
pip3 install semgrep

# Test lokalnie
swiftlint lint
semgrep --config .semgrep.yml .
```

## Krok 4: Push do GitHub

```bash
git add .
git commit -m "feat: Implementacja projektu TBO - CI/CD Security Pipeline"
git push origin main
```

## Krok 5: Sprawdź GitHub Actions

1. Idź do: https://github.com/Michal2390/TBO-project/actions
2. Zobacz czy pipeline się uruchomił
3. Sprawdź wszystkie joby (powinny przejść ✅)

## Krok 6: Utwórz gałąź z podatnościami (Zadanie 2)

```bash
git checkout -b vulnerability-injection
```

Następnie edytuj pliki aby dodać podatności - instrukcje w ZADANIE_2_INSTRUKCJE.md!
