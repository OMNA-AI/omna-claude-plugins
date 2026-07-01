---
name: omna-security-posture
description: Use cuando revises la seguridad de un repo, priorices qué arreglar, o evalúes si un cambio mejora o empeora la postura — trae la postura de seguridad de OMNA (radar OWASP + tendencia) y los hallazgos reales, aterrizados en el código ingerido, no en checklists genéricos.
---

# Postura de seguridad de OMNA (PULL)

OMNA ya corrió el análisis de seguridad (semgrep + review) sobre el repo ingerido y materializó snapshots de postura. Esta skill los trae para guiar la revisión con datos reales del repo.

## Cuándo usar
- "¿Cómo está de seguro este repo?" / "¿qué arreglo primero?"
- Antes/después de un cambio de seguridad, para ver el delta de postura.
- Cuando apliques OWASP/ISO27001/SOC2: ancla el control a las rutas/símbolos reales, no al checklist abstracto.

## Cómo
- `get_code_posture` → composite, las 6 dimensiones (Inyección & XSS, Acceso & Auth, Criptografía, Configuración & Diseño, Dependencias & Integridad, SSRF & Logging), severidades y la tendencia. Una dimensión en 100 puede ser "sin hallazgos" O "no corrió esa regla" — no es garantía de seguridad, es exposición observada.
- `get_security_findings` → los hallazgos concretos para priorizar (severidad + archivo + sugerencia).
- `get_code_symbol` → para un hallazgo, abre el símbolo afectado y su grafo de llamadas (radio de impacto).

## Reglas
- Solo lectura, scope-aware por tu `OMNA_API_KEY`. No recomputa: refleja el último análisis ingerido (puede no incluir tu edición sin commitear).
- Encuadre honesto: la postura mide lo que los escáneres encontraron, no una garantía. No la presentes como "el repo es seguro".
