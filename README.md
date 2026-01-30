# 🔒 TBO Lab 4 - iOS Security Testing Pipeline

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![Xcode](https://img.shields.io/badge/Xcode-15.0-blue.svg)
![CI](https://img.shields.io/badge/CI-GitHub%20Actions-green.svg)

## 📋 Spis treści
- [Opis projektu](#opis-projektu)
- [Wymagania](#wymagania)
- [Instalacja](#instalacja)
- [Zadania](#zadania)
- [Wyniki testów bezpieczeństwa](#-wyniki-testów-bezpieczeństwa)
- [Pełna analiza SAST vs DAST](#-pełna-analiza-sast-vs-dast)
- [Podsumowanie i wnioski](#-podsumowanie-i-wnioski)

---

## 🎯 Opis projektu

Projekt iOS demonstracyjny zawierający **celowo wprowadzone podatności bezpieczeństwa** w celu przeprowadzenia kompleksowej analizy bezpieczeństwa z wykorzystaniem:
- **SAST** (Static Application Security Testing) - SwiftLint, Semgrep
- **SCA** (Software Composition Analysis) - Dependency checking
- **DAST** (Dynamic Application Security Testing) - OWASP ZAP, Frida

### Funkcjonalności aplikacji:
1. **LoginView** - System logowania z hardcoded credentials i insecure storage
2. **DataView** - Zarządzanie plikami z insecure file permissions
3. **NetworkView** - API client z HTTP communication i exposed API keys
4. **CryptoView** - Weak encryption implementation (XOR cipher)

---

## ✅ Wymagania

### Lokalne
- macOS 13.0+
- Xcode 15.0+
- Git
- Homebrew

### Dla DAST (opcjonalnie)
- OWASP ZAP
- Charles Proxy lub Burp Suite
- Frida (dla iOS instrumentation)

---

## 🚀 Instalacja

### 1. Clone repozytorium