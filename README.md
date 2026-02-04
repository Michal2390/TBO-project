# 🔒 Security By Design - Zadanie 4
## CI/CD Security Pipeline dla iOS z SAST, SCA i DAST

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)
![Security](https://img.shields.io/badge/Security-SAST%20%7C%20SCA%20%7C%20DAST-red.svg)
![Status](https://img.shields.io/badge/Status-Complete-success.svg)

---

## 👤 Informacje o wykonawcy

**Wykonawca:** Michał Fereniec  
**Nr indeksu:** 307340  
**Przedmiot:** TBO (Testowanie Bezpieczeństwa Oprogramowania)  
**Zadanie:** Laboratorium 4 - Security By Design  
**Data oddania:** 04.02.2025  
**Repozytorium:** https://github.com/Michal2390/TBO-Lab4

---

## 📋 Spis treści

1. [Cel zadania](#-cel-zadania)
2. [✅ Zadanie 1 (opcjonalne) - Trivy](#-zadanie-1-opcjonalne---trivy-na-lokalnie-zbudowanym-obrazie)
3. [✅ Zadanie 2 (opcjonalne) - Semgrep](#-zadanie-2-opcjonalne---sast-z-wykorzystaniem-semgrep)
4. [✅ Zadanie 3 (OBOWIĄZKOWE) - CI/CD Pipeline](#-zadanie-3-obowiązkowe---przygotowanie-procesu-cicd)
5. [✅ Zadanie 4 (OBOWIĄZKOWE) - DAST z OWASP ZAP](#-zadanie-4-obowiązkowe---dast-z-owasp-zap)
6. [Architektura CI/CD](#-architektura-cicd)
7. [Wyniki testów bezpieczeństwa](#-wyniki-testów-bezpieczeństwa)
8. [Instalacja i uruchomienie](#-instalacja-i-uruchomienie)
9. [Wnioski końcowe](#-wnioski-końcowe)

---

## 🎯 Cel zadania

Celem **Zadania 4** jest:

1. ✅ Przeprowadzenie lokalnego skanowania bezpieczeństwa (Trivy, Semgrep) - **opcjonalne**
2. ✅ Zbudowanie kompletnego procesu **CI/CD** z automatycznymi testami bezpieczeństwa - **OBOWIĄZKOWE**
3. ✅ Uruchomienie aplikacji lokalnie i wykonanie **DAST** z użyciem **OWASP ZAP** - **OBOWIĄZKOWE**
4. ✅ Porównanie wyników **SAST vs DAST** i wyjaśnienie różnic - **OBOWIĄZKOWE**

### Aplikacja demonstracyjna

Aplikacja iOS **Task Manager** w SwiftUI:
- 📝 Dodawanie zadań do listy
- ✅ Oznaczanie zadań jako ukończone
- 🗑️ Usuwanie zadań
- 💾 Bezpieczne przechowywanie danych w pamięci

**Architektura:**
- `ContentView.swift` - UI aplikacji (SwiftUI)
- `Task.swift` - Model danych (Identifiable, Codable)
- `TaskManager.swift` - ViewModel (ObservableObject)
- `TBO_Lab4Tests.swift` - Testy jednostkowe (5 testów)

---

## ✅ Zadanie 1 (opcjonalne) - Trivy na lokalnie zbudowanym obrazie

### Status: ✅ ZREALIZOWANE

### Cel
Przeprowadzenie lokalnego skanowania kontenera Docker z użyciem **Trivy** w celu wykrycia podatności w zależnościach systemowych.

### Wykonane kroki

#### 1. Utworzenie Dockerfile dla aplikacji iOS

Przygotowano minimalny obraz Docker do testów (symulacja środowiska CI/CD):