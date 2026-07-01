---
name: omna-code-context
description: Use cuando vayas a entender, revisar, modificar o tomar una decisión de diseño sobre un archivo/símbolo de un repo que OMNA ingirió — trae a contexto lo que el cerebro técnico de OMNA ya sabe (postura de seguridad, vulnerabilidades, grafo de símbolos) en vez de re-derivarlo a ciegas.
---

# Contexto de código de OMNA (PULL)

El servidor MCP `omna-brain` expone, solo-lectura y scope-aware, lo que el cerebro técnico de OMNA ya calculó sobre el repo ingerido. **Antes de razonar sobre un archivo a ciegas, jala ese conocimiento.**

## Cuándo usar
- Vas a editar o refactorizar un archivo de un repo conectado a OMNA.
- Necesitas saber quién llama a un símbolo o qué llama él (impacto de un cambio).
- Vas a tomar una decisión de diseño y quieres el estado de seguridad real, no supuestos.

## Cómo
Usa estas tools del server `omna-brain` (no re-implementes su lógica):

- `get_code_posture` — postura de seguridad por repo: composite 0-100, las 6 dimensiones OWASP del radar, conteo por severidad y la **tendencia** vs el snapshot anterior. Pásale `repoUrl` (cualquier forma: `git@…`, `https://…`, `owner/repo`) para acotar.
- `get_code_symbol` — detalle de un símbolo: metadata, snippet y **grafo de llamadas directo** (callers/callees). Identifícalo por `symbolId`, o por `(repoUrl, filePath, line)` del archivo que tienes abierto.
- `get_security_findings` — hallazgos del review de seguridad (archivo, línea, severidad, descripción, sugerencia).

## Reglas
- Es **solo lectura**: estas tools nunca escriben en OMNA. No envían tu código sin commitear a ningún lado; consultan lo ya ingerido.
- El alcance lo decide tu API-key (`OMNA_API_KEY`). Si una tool responde vacío o "no ingerido", el repo/archivo no está en el scope de tu key o no se ha ingerido — dilo, no inventes.
- Cita lo que traes ("OMNA: este símbolo tiene 2 callers y un hallazgo A03 abierto") para que la decisión sea trazable.
