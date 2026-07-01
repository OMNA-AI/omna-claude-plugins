---
name: omna-coaching-mode
description: Use cuando quieras coaching de cumplimiento/seguridad sobre tu código SIN COMMITEAR (un diff, un archivo abierto, un draft) en un repo conectado a OMNA — aterriza OWASP/ISO27001/SOC2 en la postura REAL del repo (hallazgos, símbolos, charter) en vez de checklists genéricos. Tu working code nunca sale de tu máquina.
---

# Coacheo efímero del draft (PULL, razonamiento local)

Patrón **coach** del plugin OMNA (bd omna-brain-j5e.7). Antes de commitear, evalúa tu draft contra lo que OMNA **ya sabe** del repo — su postura de seguridad real, sus hallazgos abiertos, el grafo de símbolos que tu cambio toca y el charter del proyecto. El coaching es de cumplimiento **aterrizado en datos reales del repo**, no un checklist OWASP genérico.

**INVARIANTE de esta skill (no negociable):** tu working code (lo que aún no commiteas) **nunca se envía a OMNA**. El razonamiento ocurre aquí, en tu Claude Code. OMNA solo SIRVE, solo-lectura y scope-aware, lo que ya ingirió del código commiteado. No existe ninguna tool que reciba tu draft — si te ves a punto de "mandar el código para analizarlo", PARA: no es lo que hace este modo.

## Cuándo usar
- Tienes cambios sin commitear (o un archivo/diff abierto) y vas a evaluarlos antes de commitear/abrir PR.
- Quieres saber si tu draft introduce o agrava un riesgo de seguridad/cumplimiento, contra la postura real del repo.
- Quieres dimensionar el impacto de tu cambio (qué llama al símbolo que tocas) y si choca con una decisión del charter del proyecto.

## Cómo
1. **Mantén el draft local.** Léelo de tu working tree / buffer — NO lo pegues en ningún argumento de tool.
2. **Jala el aterrizaje del repo** con estas tools del server `omna-brain` (solo-lectura, scope-aware por tu `OMNA_API_KEY`; pásales `repoUrl` para acotar):
   - `get_code_posture` — composite 0-100, las 6 dimensiones OWASP del repo, conteo por severidad y tendencia. Te dice *dónde* el repo ya está débil → prioriza ahí tu revisión del draft.
   - `get_security_findings` — hallazgos abiertos (archivo, línea, severidad, OWASP, regla). Cruza las líneas que tu draft toca contra los hallazgos existentes: ¿tu cambio cae sobre/junto a un hallazgo abierto?, ¿lo cierra?, ¿lo agrava?
   - `get_code_symbol` — para cada símbolo que tu draft modifica, identifícalo por `(repoUrl, filePath, line)` → te da metadata, snippet del código YA ingerido y el grafo de llamadas directo (callers/callees). Úsalo para el **impacto**: cuántos callers afecta tu cambio.
   - `get_project_charter` — el charter del proyecto cliente (si lo ingirió). Adjudica tu draft contra sus principios/invariantes (mismo espíritu que `omna-design-check`).
3. **Razona TÚ, localmente**, el draft contra ese aterrizaje:
   - **Cumplimiento aterrizado:** mapea cada riesgo del draft a la dimensión OWASP donde el repo ya está débil y a hallazgos concretos — "tu draft toca `auth.ts:42`, junto al hallazgo A01 abierto; este patrón agravaría 'Acceso & Auth' que ya está en X/100". Para ISO27001/SOC2, ata la observación al control real (p.ej. A.8 control de acceso, CC6.1) solo si el dato del repo lo respalda; nada de checklist genérico.
   - **Impacto:** usa callers/callees para decir a qué arrastra el cambio.
   - **Diseño:** si toca algo que el charter ya decidió, cítalo.
4. **Entrega el coaching al dev** con citas trazables a lo que jalaste ("OMNA: este archivo tiene un A03 abierto en la línea 88; tu draft añade otra concatenación de SQL ahí mismo").

## Reglas
- **Cero fuga:** el working code se queda en tu máquina. Estas tools consultan lo ya ingerido (commiteado), nunca reciben tu draft. No persisten nada en OMNA.
- El alcance lo decide tu `OMNA_API_KEY` (scope-aware, estrechable por repo). Si una tool responde vacío o "no ingerido", ese repo/archivo no está en tu scope o no se ha ingerido — dilo, no inventes una postura.
- El SAST fresco sobre líneas no commiteadas está **fuera de alcance** por diseño (requeriría mandar tu código a OMNA). Aquí razonas tu draft contra la postura del código ya ingerido; corre tu linter/SAST local para el draft crudo.
- Cita siempre el dato real en que te apoyas, para que el coaching sea trazable y no un checklist.
