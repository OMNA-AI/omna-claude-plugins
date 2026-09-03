# OMNA — Claude Code plugins · **RETIRADO (2026-09-03)**

> **Este plugin ya no se mantiene y no debe instalarse.** No se publicó nunca a clientes.
> El repositorio queda archivado como registro; lo que hacía vive ahora en dos sitios
> distintos, a propósito.

## Qué usar en su lugar

**Para conectarte al cerebro de OMNA (las tools MCP), declara el servidor a mano con tu clave
literal:**

```bash
claude mcp add omna-brain https://brain.omna.club/api/mcp \
  --transport http -s user \
  --header "Authorization: Bearer op_TU_CLAVE"
```

La clave se emite en `brain.omna.club` → Configuración → **Claves API**. **Elige un ÁREA**: una
clave sin vincular no sirve para MCP (el servidor la rechaza). Si trabajas en varias áreas de la
misma organización, márcalas en «Otras áreas que abarca» y **una sola clave las cubre** — el
cliente las lista con `list_workspaces` y elige con el parámetro `workspaceId` de cada tool.

**Las skills** (`omna-code-context`, `omna-security-posture`, `omna-design-check`,
`omna-coaching-mode`, `omna-recommendations`) viven en `.claude/skills/` del repo `omna-brain`,
donde llegan con un `git pull` en vez de haber que instalarlas.

## Por qué se retiró, en una línea

Empaquetaba juntas dos cosas que pertenecen a canales distintos: el **transporte** (la conexión
MCP) y el **valor** (las skills). Su `.mcp.json` declaraba el servidor con
`Authorization: Bearer ${OMNA_API_KEY}`, así que el transporte se podía declarar **dos veces** —el
plugin y la config de la persona, ambos con el mismo nombre— y **fallaba en silencio**: si la
variable de entorno no estaba donde Claude Code la ve, el header viajaba literal y el servidor
respondía el mismo 401 que daría una clave inexistente.

La regla que quedó: **el transporte es configuración por persona y va con credencial literal; el
valor va en el repo.**
