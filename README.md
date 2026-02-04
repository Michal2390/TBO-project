# 🔒 TBO - Laboratorium 4: CI/CD Security Pipeline

![Swift](https://img.shields.io/badge/Swift-5.9-orange.svg)
![iOS](https://img.shields.io/badge/iOS-17.0+-blue.svg)
![CI/CD](https://img.shields.io/badge/CI/CD-GitHub%20Actions-green.svg)
![Security](https://img.shields.io/badge/Security-SAST%20%7C%20SCA%20%7C%20DAST-red.svg)

## 👥 Informacje

**Wykonał:** Michał Fereniec 307340  
**Przedmiot:** TBO (Testowanie Bezpieczeństwa Oprogramowania)  
**Laboratorium:** 4 - Security By Design  
**Repozytorium:** https://github.com/Michal2390/TBO-Lab4

---

## 📋 Spis Treści

1. [Cel laboratorium](#-cel-laboratorium)
2. [Zrealizowane zadania](#-zrealizowane-zadania)
3. [Zadanie 3 - Proces CI/CD](#-zadanie-3---proces-cicd-obowiązkowe)
4. [Zadanie 4 - DAST z OWASP ZAP](#-zadanie-4---dast-z-owasp-zap-obowiązkowe)
5. [Instalacja i uruchomienie](#-instalacja-i-uruchomienie)
6. [Wnioski](#-wnioski)

---

## 🎯 Cel laboratorium

Laboratorium 4 ma na celu zapoznanie się z **automatyzacją testów bezpieczeństwa** w procesie CI/CD poprzez:
- ✅ Implementację **SAST** (Static Application Security Testing) z użyciem Semgrep
- ✅ Implementację **SCA** (Software Composition Analysis) z użyciem Trivy
- ✅ Implementację **DAST** (Dynamic Application Security Testing) z użyciem OWASP ZAP
- ✅ Automatyczne blokowanie deployment'u przy wykryciu podatności

### Aplikacja demonstracyjna:
Prosta aplikacja iOS do zarządzania zadaniami (Task Manager) w SwiftUI:
- 📝 Dodawanie zadań
- ✅ Oznaczanie jako ukończone
- 🗑️ Usuwanie zadań

---

## ✅ Zrealizowane zadania

### ✅ Zadanie 1 (opcjonalne): Trivy na lokalnie zbudowanym obrazie
**Status:** ✅ Zrealizowane  
**Opis:** Przeprowadzono skanowanie obrazu Docker z użyciem Trivy lokalnie, weryfikując wykrywanie podatności w zależnościach systemowych.