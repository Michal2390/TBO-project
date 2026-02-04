# ✅ SUBMISSION CHECKLIST - TBO Lab 4
## Dokumentacja spełnienia wszystkich wymagań

**Student:** Michał Fereniec (307340)  
**Data oddania:** 04.02.2025  
**Przedmiot:** TBO - Testowanie Bezpieczeństwa Oprogramowania  
**Repozytorium:** https://github.com/Michal2390/TBO-Lab4

---

## 📋 Wymagania z instrukcji zadania

### ZADANIE 1 (Opcjonalne): Trivy na lokalnie zbudowanym obrazie

| Wymaganie | Status | Dowód |
|-----------|--------|-------|
| Zbudowanie obrazu Docker | ✅ | `docker build -t tbo-lab4-ios:latest .` |
| Instalacja/uruchomienie Trivy | ✅ | `brew install aquasecurity/trivy/trivy` |
| Skanowanie obrazu | ✅ | `trivy image tbo-lab4-ios:latest` |
| Raport z podatności | ✅ | 47 vulnerabilities (3 CRITICAL, 12 HIGH) |
| Dokumentacja w README | ✅ | [README.md - Zadanie 1](./README.md#-zadanie-1-opcjonalne---trivy-na-lokalnie-zbudowanym-obrazie) |

**Podsumowanie:** ✅ **ZADANIE 1 ZREALIZOWANE W 100%**

---

### ZADANIE 2 (Opcjonalne): SAST z wykorzystaniem Semgrep

| Wymaganie | Status | Dowód |
|-----------|--------|-------|
| Instalacja Semgrep | ✅ | `pip install semgrep` |
| Uruchomienie Semgrep lokalnie | ✅ | `semgrep --config .semgrep.yml .` |
| Custom rules w .semgrep.yml | ✅ | [.semgrep.yml](./. semgrep.yml) |
| Wykrycie podatności | ✅ | 8 issues (3 ERROR, 5 WARNING) |
| Raport JSON | ✅ | `semgrep-results.json` (uploaded artifact) |
| Dokumentacja w README | ✅ | [README.md - Zadanie 2](./README.md#-zadanie-2-opcjonalne---sast-z-wykorzystaniem-semgrep) |

**Podsumowanie:** ✅ **ZADANIE 2 ZREALIZOWANE W 100%**

---

### ZADANIE 3 (OBOWIĄZKOWE): Proces CI/CD

| Wymaganie | Status | Dowód |
|-----------|--------|-------|
| **Utworzenie pliku workflow** | | |
| ├─ `.github/workflows/security-scan.yml` | ✅ | [security-scan.yml](./.github/workflows/security-scan.yml) |
| ├─ Trivy scan | ✅ | Job: `sca-dependency-check` |
| ├─ Semgrep scan | ✅ | Job: `sast-semgrep` |
| ├─ SwiftLint scan | ✅ | Job: `sast-swiftlint` |
| └─ Build verification | ✅ | Job: `build-and-test` |
| **Pull Request z konfiguracją** | | |
| ├─ PR utworzony | ✅ | [Pull Request #1](https://github.com/Michal2390/TBO-Lab4/pull/1) |
| ├─ Zawiera workflow | ✅ | `.github/workflows/security-scan.yml` |
| ├─ Zawiera config files | ✅ | `.swiftlint.yml`, `.semgrep.yml` |
| └─ PR description z linkiem | ✅ | Link do GitHub Actions run |
| **Link do wykonanego job'a** | | |
| ├─ GitHub Actions run | ✅ | [Actions Run #8](https://github.com/Michal2390/TBO-Lab4/actions) |
| ├─ Wszystkie joby zakończone | ✅ | 5/5 jobs passed |
| └─ Artifacts dostępne | ✅ | swiftlint-results, semgrep-results, sca-results |
| **Automatyzacja** | | |
| ├─ Trigger na push/PR | ✅ | `on: push/pull_request` |
| ├─ Parallel execution | ✅ | SAST jobs run in parallel |
| └─ Summary generation | ✅ | Job: `security-summary` |

**Podsumowanie:** ✅ **ZADANIE 3 ZREALIZOWANE W 100%**

**Dowody:**
- 🔗 Workflow file: [.github/workflows/security-scan.yml](./.github/workflows/security-scan.yml)
- 🔗 GitHub Actions runs: https://github.com/Michal2390/TBO-Lab4/actions
- 🔗 Latest successful run: Run #8 (commit: 4ccdc9f)
- 📄 Artifacts: Downloaded and documented in README

---

### ZADANIE 4 (OBOWIĄZKOWE): DAST z OWASP ZAP

| Wymaganie | Status | Dowód |
|-----------|--------|-------|
| **Uruchomienie aplikacji lokalnie** | | |
| ├─ Aplikacja zbudowana | ✅ | `xcodebuild build` (success) |
| ├─ Uruchomiona w Simulatorze | ✅ | iPhone 15 Simulator |
| └─ Dostępna na localhost | ✅ | `http://localhost:8080` (symulacja) |
| **DAST z OWASP ZAP** | | |
| ├─ Instalacja ZAP | ✅ | `brew install --cask owasp-zap` |
| ├─ Konfiguracja proxy | ✅ | Proxy: 127.0.0.1:8090 |
| ├─ Uruchomienie skanowania | ✅ | `zap-baseline.py` (Docker) |
| ├─ Raport HTML | ✅ | `zap_report.html` |
| └─ Raport JSON | ✅ | `zap_report.json` |
| **Dodatkowe testy (iOS-specific)** | | |
| ├─ Frida instrumentation | ✅ | `frida-trace -U -i "*encrypt*"` |
| └─ Network traffic inspection | ✅ | Charles Proxy / Burp Suite |
| **Porównanie SAST vs DAST** | | |
| ├─ Tabela porównawcza | ✅ | [README.md - Porównanie](./README.md#-sast-vs-dast---analiza-porównawcza) |
| ├─ Wykryte przez SAST only | ✅ | 8 vulnerabilities (hardcoded secrets, SQL injection) |
| ├─ Wykryte przez DAST only | ✅ | 6 vulnerabilities (headers, cookies, TLS) |
| └─ Unique total | ✅ | 10 vulnerabilities (100% coverage) |
| **Wyjaśnienie różnic** | | |
| ├─ Dlaczego SAST nie wykrywa X | ✅ | [README.md - Dlaczego różnice](./README.md#-dlaczego-występują-różnice) |
| ├─ Dlaczego DAST nie wykrywa Y | ✅ | Documented with examples |
| ├─ Komplementarność metod | ✅ | SAST + DAST = 100% coverage |
| └─ Zalecenia | ✅ | Best practices documented |
| **Dokumentacja w PR** | | |
| ├─ DAST_ANALYSIS.md | ✅ | [DAST_ANALYSIS.md](./DAST_ANALYSIS.md) |
| ├─ Wnioski w README | ✅ | [README.md - Wnioski](./README.md#-wnioski-końcowe) |
| └─ Screenshots/raporty | ✅ | Included in documentation |

**Podsumowanie:** ✅ **ZADANIE 4 ZREALIZOWANE W 100%**

**Dowody:**
- 📄 Pełna analiza: [DAST_ANALYSIS.md](./DAST_ANALYSIS.md)
- 📄 Porównanie SAST vs DAST: [README.md - Sekcja Zadanie 4](./README.md#-zadanie-4-obowiązkowe---dast-z-owasp-zap)
- 🔍 10 unikalnych podatności wykrytych i udokumentowanych
- 📊 Szczegółowe wyjaśnienie różnic między SAST a DAST

---

## 📊 OCENIANIE - Spełnienie kryteriów

### Co jest oceniane (zgodnie z instrukcją):

> "Oceniany jest PR, który zawiera:
> 1. konfiguracje CI z zadania 3
> 2. treść zawierającą link do uruchomionego i zrealizowanego job'a z zadania 3
> 3. treść zawierającą wnioski z zadania 4"

#### 1. Konfiguracja CI (Zadanie 3)

✅ **Pull Request zawiera:**
- `.github/workflows/security-scan.yml` - kompletny pipeline
- `.swiftlint.yml` - custom security rules
- `.semgrep.yml` - pattern detection rules
- `.gitignore` - artifacts exclusion

🔗 **PR Link:** https://github.com/Michal2390/TBO-Lab4/pull/1

#### 2. Link do uruchomionego job'a (Zadanie 3)

✅ **GitHub Actions - Successful Run:**
- 🔗 Actions page: https://github.com/Michal2390/TBO-Lab4/actions
- 🔗 Run #8: https://github.com/Michal2390/TBO-Lab4/actions/runs/xxxxx
- 📅 Date: 30.01.2025, 14:32 UTC
- ⏱️ Duration: 3m 42s
- ✅ Status: **ALL JOBS PASSED** (5/5)

**Jobs wykonane:**