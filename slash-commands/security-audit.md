---
name: Security Audit
description: Comprehensive adversarial security audit across all application layers. Acts as a senior security engineer and red-team specialist to identify critical, high, medium, and low severity vulnerabilities including logic flaws, chained attack paths, and novel attack vectors. Use when preparing for deployment, after major feature additions, or when running a formal security review.
tags: security, audit, vulnerabilities, penetration, red-team, adversarial
---

# Security Audit

Perform a comprehensive, adversarial security audit of the codebase, system design, or application.

## Usage

```
/security-audit                     # Full audit across all layers
/security-audit --frontend          # Frontend + client-side only
/security-audit --backend           # Backend + API only
/security-audit --auth              # Authentication flows only
/security-audit --critical          # Critical and High severity only
/security-audit --deps              # Dependencies and supply chain only
/security-audit --dry-run           # List audit scope before running
```

## Scope

Analyzes all layers:

- **Frontend** — UI, client logic, browser storage
- **Backend** — APIs, business logic, services
- **Authentication & Authorization** — login flows, sessions, tokens, permissions
- **Database** — queries, schema, storage, migrations
- **Infrastructure** — deployment assumptions, env config, headers
- **Dependencies** — third-party packages, supply chain risks

---

## Audit Process

### Step 1: Threat Modeling

Before analyzing code, define:

- **Attacker profiles**: anonymous user, authenticated user, insider, API consumer
- **Entry points**: all public surfaces (APIs, forms, file uploads, headers)
- **Trust boundaries**: where system trusts external input
- **Sensitive assets**: tokens, secrets, PII, permissions, payment data

### Step 2: Vulnerability Analysis

Check across all categories below. Do NOT limit to this list — be adversarial and creative.

#### Authentication & Authorization
- Broken auth, weak session management
- Privilege escalation (vertical and horizontal)
- Insecure password reset flows
- Token leakage or reuse
- Missing or bypassable authorization checks (IDOR/BOLA)

#### Input Handling
- Injection attacks (SQL, NoSQL, OS command, template injection)
- XSS (stored, reflected, DOM-based)
- CSRF vulnerabilities
- File upload exploits (type bypass, path traversal, execution)

#### Data Security
- Sensitive data exposure in logs, responses, or errors
- Weak encryption or misuse of cryptography
- Hardcoded secrets or API keys
- Insecure storage (localStorage, cookies without flags, unencrypted DB fields)

#### API & Backend Logic
- Mass assignment vulnerabilities
- Rate limiting gaps / brute force risks
- Business logic abuse (race conditions, double spending, bypassing checks)
- Broken object-level authorization

#### Infrastructure & Configuration
- Misconfigured headers (CORS, CSP, HSTS, X-Frame-Options)
- Debug endpoints or admin panels exposed
- Environment variable leaks
- Cloud/storage misconfigurations

#### Dependencies & Supply Chain
- Vulnerable packages (check against CVE databases)
- Unsafe imports or dynamic execution
- Malicious or abandoned dependency risks

### Step 3: Advanced / Unknown Threats

Actively attempt to discover:

- Non-obvious logic flaws unique to this system
- Feature abuse scenarios
- State desynchronization issues
- Cache poisoning
- Replay attacks
- Timing attacks
- Multi-step exploit chains combining low-severity issues
- Any behavior that "shouldn't be possible" but might be

### Step 4: Adversarial Mindset Checks

- Think like an attacker trying to break assumptions
- Attempt to bypass validations and safeguards
- Manipulate edge cases and unexpected inputs
- Explore how different components interact under stress

---

## Output Format

### 1. Vulnerability Summary

| Severity | Count |
|---|---|
| 🔴 Critical | N |
| 🟠 High | N |
| 🟡 Medium | N |
| 🟢 Low | N |

### 2. Detailed Findings

For each vulnerability:

```
#### [Title]

**Severity**: Critical / High / Medium / Low
**Affected component**: [frontend / backend / auth / DB / infra / deps]
**Description**: [what the issue is]
**Exploitation scenario**:
  1. Attacker does X
  2. System responds with Y
  3. Attacker gains Z
**Impact**: [what is at risk]
**Recommended fix**: [specific, actionable]
```

### 3. Attack Chains

Show how multiple lower-severity issues combine into a major exploit:

```
[Low] Info disclosure in error message
  + [Medium] Predictable token format
  + [Low] Missing rate limiting
  = [Critical] Account takeover without credentials
```

### 4. Secure Design Recommendations

- Architectural improvements
- Safer patterns and best practices
- Suggested libraries or tools

---

## Important Instructions (for AI executing this command)

- Do NOT assume the code is safe
- Do NOT skip analysis due to missing context — infer risks where needed
- Be exhaustive and paranoid
- If unsure, flag as a potential risk and explain why
- Surface novel and chained vulnerabilities, not just OWASP Top 10

---

## Relationship to Existing Hooks

| Tool | Purpose |
|---|---|
| `hooks/security` | Lightweight automated gate: secrets scan + large files + .env check. Runs on every commit. |
| `/security-audit` | Deep, adversarial full-system audit. Run on demand before deployment or major releases. |

These complement each other — hooks catch accidents, `/security-audit` catches architectural flaws.

---

## Aliases

- `/audit`
- `/pentest`
- `/sec-audit`
