---
name: omna-design-check
description: Use ANTES de comprometer una decisión de diseño/arquitectura en un repo conectado a OMNA — cambios de esquema, ACL/scoping, dependencias estructurales, modelo de auth/keys, contratos de API. Trae el charter del proyecto cliente desde OMNA y adjudica la decisión contra sus principios e invariantes antes de construir.
---

# Adjudicación contra el charter del proyecto (PULL)

Patrón **adjudicador** del plugin OMNA. Muchos proyectos cliente front-loadean sus decisiones caras de revertir en un charter (`CHARTER.md`, `docs/charter/*`). Antes de comprometer una decisión de diseño, **tráelo y adjudica contra él** — no decidas a ciegas y luego choques con un invariante.

## Cuándo usar
- Vas a cambiar esquema/DB, ACL/scoping, modelo de auth/keys, un contrato de API, o a añadir una dependencia estructural.
- La decisión es cara de revertir o toca algo que el proyecto ya decidió a propósito.

## Cómo
1. Llama `get_project_charter` (server `omna-brain`; opcional `repoUrl`) → te devuelve el texto del/los doc(s) de charter ingeridos.
2. Adjudica TÚ la decisión contra ese texto (el razonamiento es local; OMNA solo sirve el texto):
   - **Consistente** con principios/invariantes → procede, citando qué principio la respalda.
   - **Choca con un invariante** → PARA. Cita el invariante exacto y plantéaselo al usuario antes de construir.
   - **Choca con una decisión más blanda** → ¿sirve mejor a la misión? Si sí, es aprendizaje (propón actualizar el charter); si no, es drift (vuelve al camino consistente).
3. Si `get_project_charter` devuelve vacío (no hay charter ingerido), dilo explícitamente y adjudica con el contexto disponible — no inventes invariantes.

## Reglas
- Solo lectura, scope-aware por tu `OMNA_API_KEY`. El charter que ves es el del/los repo(s) en tu scope.
- Cita textualmente el principio/invariante en que te apoyas, para que la decisión sea trazable (mismo espíritu que el charter-check de OMNA).
