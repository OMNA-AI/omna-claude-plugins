# OMNA — Recomendaciones del cerebro de código

Usa la tool MCP **`get_recommendations`** de OMNA Brain para saber qué mejorar en
la calidad del código de este repo y cómo aplicarlo.

## Cuándo usarla
- Al empezar una sesión de trabajo en el repo, o cuando el usuario pregunte
  "¿cómo mejoro este código?", "¿qué debería atacar?", "¿cómo subo el score?".
- Antes de un refactor amplio, para apuntar al punto más débil (el *gap*).

## Qué devuelve
Por cada cerebro de código en tu scope: la salud actual (`composite`) y hasta 3
recomendaciones apuntadas a la métrica más débil (atomicity / coupling /
duplication / testing), cada una con:
- `estimatedUplift` + `estimatedHorizonCommits`: el efecto estimado y en cuántos
  commits (proyección por tendencia / ITS, **no** una garantía).
- `priorSource`: `curated` = estimación base de OMNA aún sin medir en tu repo;
  `observed`/`blend` = ya calibrado con TUS commits.
- `artifact` + `artifactPath`: el contenido REAL a instalar y su ruta destino.

## Cómo APLICAR una recomendación
Cuando el usuario acepte una:
1. Toma `artifact` (el contenido) y `artifactPath` (p.ej.
   `.claude/skills/tdd-guard/SKILL.md`, `CLAUDE.md`, o `(prompt)`).
2. Si `artifactPath` es una ruta de archivo → **escribe** el `artifact` en esa
   ruta del repo (crea el archivo o añade el bloque a `CLAUDE.md`).
3. Si `artifactPath` es `(prompt)` → úsalo como prompt en la conversación.
4. No inventes contenido: aplica el `artifact` tal cual lo devolvió la tool.

## Honestidad
Comunica el `priorSource`: si es `curated`, aclara que es una estimación inicial
de OMNA (aún sin datos de este repo), no un efecto medido. El número se vuelve
real conforme el repo acumula commits tras adoptar la práctica.
