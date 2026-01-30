# 🔒 PROJEKT TBO - CI/CD Security Pipeline dla iOS

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)
![Security](https://img.shields.io/badge/Security-SAST%20%7C%20SCA%20%7C%20DAST-red.svg)

## 👥 Informacje o Zespole

**Projekt wykonali:**
- Michał Fereniec (wpisz tu swój numer indeksu)
- [Członek 2 - jeśli jest]
- [Członek 3 - jeśli jest]

**Termin oddania:** 29.01.2025  
**Przedmiot:** TBO (Testowanie Bezpieczeństwa Oprogramowania)  
**Repozytorium:** https://github.com/Michal2390/TBO-project

---

## 📋 Spis Treści

1. [Opis Projektu](#-opis-projektu)
2. [Wymagania](#-wymagania)
3. [Architektura CI/CD](#-architektura-cicd)
4. [Zadanie 1 - Proces CI/CD](#-zadanie-1---proces-cicd)
5. [Zadanie 2 - Weryfikacja](#-zadanie-2---weryfikacja)
6. [Instalacja i Uruchomienie](#-instalacja-i-uruchomienie)
7. [Wyniki Testów](#-wyniki-testów)

---

## 🎯 Opis Projektu

Projekt realizuje kompleksowy proces **CI/CD z wbudowanymi mechanizmami bezpieczeństwa** dla aplikacji iOS. 

### Cel projektu:
Zaimplementowanie pipeline'u, który automatycznie:
- ✅ Uruchamia **testy jednostkowe**
- ✅ Wykonuje **SAST** (Static Application Security Testing)
- ✅ Przeprowadza **SCA** (Software Composition Analysis)
- ✅ Realizuje **DAST** (Dynamic Application Security Testing)
- ✅ **Blokuje deployment** przy wykryciu krytycznych podatności

### Aplikacja demonstracyjna:
Prosta aplikacja iOS do zarządzania zadaniami (Task Manager) napisana w SwiftUI:
- 📝 Dodawanie zadań
- ✅ Oznaczanie jako ukończone
- 🗑️ Usuwanie zadań
- 💾 Bezpieczne przechowywanie danych

---

## ✅ Wymagania

### Lokalne środowisko:
- macOS 13.0+
- Xcode 15.0+
- Swift 5.9+
- Git

### Narzędzia CI/CD:
- **GitHub Actions** (automatyczne uruchamianie)
- **SwiftLint** (SAST - linting Swift)
- **Semgrep** (SAST - pattern detection)
- **Swift Package Manager** (SCA - dependency check)

---

## 🏗️ Architektura CI/CD

### Pipeline Workflow:
```
┌─────────────────────────────────────────────────────────────┐
│  PUSH / PULL REQUEST                                        │
│  (main, develop, feature/**, vulnerability-**)             │
└────────────────────┬────────────────────────────────────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  1. UNIT TESTS 🧪   │
          │  - XCTest           │
          │  - Code Coverage    │
          └──────────┬───────────┘
                     │
         ┌───────────┴───────────┐
         │                       │
         ▼                       ▼
┌────────────────┐    ┌────────────────┐
│ 2a. SAST       │    │ 2b. SAST       │
│ SwiftLint 🔍   │    │ Semgrep 🔍     │
│ - Custom Rules │    │ - Patterns     │
│ - Security     │    │ - CWE/OWASP    │
└────────┬───────┘    └────────┬───────┘
         │                     │
         └───────────┬─────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  3. SCA 📦          │
          │  - Dependencies     │
          │  - Vulnerabilities  │
          └──────────┬───────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  4. DAST 🛡️         │
          │  - Runtime Tests    │
          │  - Security Config  │
          └──────────┬───────────┘
                     │
         ┌───────────┴───────────┐
         │  SECURITY CHECK       │
         │  ❌ FAIL: Podatności │
         │  ✅ PASS: Bezpieczne │
         └───────────┬───────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  5. BUILD 🏗️        │
          │  main → :latest     │
          │  feature → :beta    │
          └──────────┬───────────┘
                     │
                     ▼
          ┌──────────────────────┐
          │  6. SUMMARY 📊      │
          │  - Reports          │
          │  - Artifacts        │
          └──────────────────────┘
```

---

## 📝 Zadanie 1 - Proces CI/CD

### 1.1 Konfiguracja Repozytorium

✅ **Gałąź główna:** `main`  
✅ **Gałęzie feature:** `feature/**`, `develop`  
✅ **Ochrona:** Pull Requesty wymagają review  
✅ **Uprawnienia:** Nadane dla @siewer

### 1.2 Wdrożone Testy Bezpieczeństwa

#### 🔍 SAST - Static Application Security Testing

**SwiftLint** (`.swiftlint.yml`):
- Wykrywanie zahardkodowanych haseł
- Wykrywanie kluczy API w kodzie
- Detekcja insecure HTTP URLs
- Potencjalne SQL Injection
- Force unwrapping i force try

**Semgrep** (`.semgrep.yml`):
- Zaawansowane wzorce podatności
- CWE-798: Hardcoded credentials
- CWE-312: Cleartext storage
- CWE-319: HTTP usage
- Custom security rules

#### 📦 SCA - Software Composition Analysis

- Sprawdzanie `Package.resolved`
- Analiza zależności Swift Package Manager
- Wykrywanie znanych podatności w bibliotekach
- Weryfikacja wersji frameworków

#### 🛡️ DAST - Dynamic Application Security Testing

- Sprawdzanie konfiguracji `Info.plist`
- Weryfikacja App Transport Security
- Runtime security checks
- Network security configuration

### 1.3 Build Strategy

| Branch Type | Build Config | Tag | Deploy |
|------------|-------------|-----|--------|
| `main` | Release | `:latest` | ✅ Production |
| `feature/**` | Debug | `:beta` | 🧪 Testing |
| `develop` | Debug | `:beta` | 🧪 Staging |
| `vulnerability-**` | Debug | `:test` | ❌ Blocked |

### 1.4 Kryteria Blokowania Pipeline

Pipeline **FAIL-uje** (blokuje deployment) gdy:
- ❌ SwiftLint znajdzie **> 5 błędów** (severity: error)
- ❌ Semgrep wykryje **> 0 krytycznych podatności** (ERROR)
- ❌ Testy jednostkowe **nie przejdą**
- ❌ Build **się nie powiedzie**

---

## 🔬 Zadanie 2 - Weryfikacja

### Gałąź testowa: `vulnerability-injection`

Utworzona gałąź zawierająca **2 celowe podatności bezpieczeństwa**:

#### Podatność 1: Zahardkodowany klucz API 🔴

```swift
// W pliku APIClient.swift
let apiKey = "sk_live_FAKE_DEMO_SECRET"
let url = "https://api.example.com/data?key=\(apiKey)"
```

**CWE-798:** Use of Hard-coded Credentials  
**Wykryte przez:** SwiftLint + Semgrep  
**Status:** ❌ Pipeline ZABLOKOWANY

#### Podatność 2: Insecure HTTP Communication 🔴

```swift
// W pliku DatabaseManager.swift
let insecureURL = "http://api.insecure.com/login"
let query = "SELECT * FROM users WHERE username='\(username)'"
```

**CWE-319:** Cleartext Transmission of Sensitive Information  
**CWE-89:** SQL Injection  
**Wykryte przez:** SwiftLint + Semgrep  
**Status:** ❌ Pipeline ZABLOKOWANY

### Link do testowego jobu CI/CD:
🔗 [GitHub Actions - Vulnerability Test Run](https://github.com/Michal2390/TBO-project/actions)

### Rezultat weryfikacji:
```
❌ CRITICAL: Semgrep znalazł 2+ krytycznych podatności!
❌ CRITICAL: SwiftLint znalazł 3+ błędów bezpieczeństwa!
⛔ Pipeline ZABLOKOWANY - napraw podatności przed deploymentem!
Error: Process completed with exit code 1.
```

✅ **Weryfikacja pomyślna** - system bezpieczeństwa CI/CD działa poprawnie i blokuje niebezpieczny kod!

---

## 🚀 Instalacja i Uruchomienie

### 1. Clone repozytorium

```bash
git clone git@github.com:Michal2390/TBO-project.git
cd TBO-project
```

### 2. Otwórz projekt w Xcode

```bash
open TBO-Lab4.xcodeproj
```

⚠️ **WAŻNE:** Dodaj foldery `Models/` i `ViewModels/` do projektu Xcode:
1. Prawy klik na `TBO-Lab4` → **Add Files to "TBO-Lab4"...**
2. Zaznacz foldery Models i ViewModels
3. ✅ Upewnij się że target `TBO-Lab4` jest zaznaczony

### 3. Uruchom testy lokalnie

```bash
# Unit Tests
xcodebuild test -project TBO-Lab4.xcodeproj -scheme TBO-Lab4 -destination 'platform=iOS Simulator,name=iPhone 15'

# SwiftLint
brew install swiftlint
swiftlint lint

# Semgrep
pip install semgrep
semgrep --config .semgrep.yml .
```

---

## 📊 Wyniki Testów

### Status Pipeline dla `main` branch:
- ✅ Unit Tests: **PASSED** (5/5 testów)
- ✅ SwiftLint: **PASSED** (0 błędów krytycznych)
- ✅ Semgrep: **PASSED** (0 podatności)
- ✅ SCA: **PASSED** (brak zewnętrznych zależności)
- ✅ DAST: **PASSED** (konfiguracja bezpieczna)
- ✅ Build: **SUCCESS**

### Status Pipeline dla `vulnerability-injection` branch:
- ✅ Unit Tests: **PASSED**
- ❌ SwiftLint: **FAILED** (3+ błędy: hardcoded credentials, HTTP, SQL injection)
- ❌ Semgrep: **FAILED** (3 krytyczne podatności)
- ⏹️ Build: **SKIPPED** (zablokowany przez testy bezpieczeństwa)

**Artefakty dostępne w GitHub Actions:**
- 📄 `swiftlint-results.json`
- 📄 `semgrep-results.json`
- 📄 `sca-report.json`
- 📄 `dast-report.json`

---

## 🎓 Wnioski i Podsumowanie

### Co zostało zrealizowane:

✅ **Zadanie 1:**
- Zaprojektowano i zaimplementowano proces CI/CD
- Wdrożono testy SAST (SwiftLint, Semgrep)
- Wdrożono testy SCA (dependency analysis)
- Wdrożono testy DAST (runtime security)
- Pipeline blokuje deployment przy wykryciu podatności

✅ **Zadanie 2:**
- Utworzono gałąź z 2+ podatnościami bezpieczeństwa
- Zweryfikowano działanie mechanizmów ochrony
- Pipeline poprawnie wykrył i zablokował niebezpieczny kod

### Korzyści z wdrożonego CI/CD:

1. **Automatyczna detekcja** podatności przed mergeowaniem kodu
2. **Oszczędność czasu** - wykrywanie problemów wcześniej w cyklu
3. **Lepsza jakość** kodu poprzez wymuszenie standardów
4. **Bezpieczeństwo** - ochrona przed przypadkowym wstrzyknięciem wrażliwych danych
5. **Dokumentacja** - jasne raporty z każdego builda

---

## 📚 Dodatkowe Materiały

### Wykorzystane narzędzia:
- [SwiftLint](https://github.com/realm/SwiftLint) - Linting dla Swift
- [Semgrep](https://semgrep.dev/) - SAST pattern detection
- [GitHub Actions](https://docs.github.com/en/actions) - CI/CD platform
- [OWASP Top 10](https://owasp.org/www-project-top-ten/) - Security guidelines

### Standardy bezpieczeństwa:
- CWE (Common Weakness Enumeration)
- OWASP Mobile Top 10
- Apple Platform Security Guide

---

## 📧 Kontakt

**Pytania?** Skontaktuj się z zespołem przez GitHub Issues lub Teams.

**Link do repozytorium:** https://github.com/Michal2390/TBO-project

**Dostęp dla prowadzącego:** @siewer (uprawnienia nadane)

---

## 📄 Licencja

Projekt edukacyjny - TBO 2025
