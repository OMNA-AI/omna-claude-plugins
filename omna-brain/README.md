# OMNA Brain — plugin de Claude Code

Trae el **cerebro técnico de OMNA** a tu editor: postura de seguridad, vulnerabilidades y grafo de símbolos del repo que OMNA ingirió, **solo-lectura y scope-aware**. (bd omna-brain-j5e)

## Qué incluye
- **MCP server `omna-brain`** (HTTP) → `https://brain.omna.club/api/mcp`. Tools: `get_code_posture`, `get_code_symbol`, `get_security_findings` (+ las tools de notas/datasets del workspace).
- **Skills**: `omna-code-context` (jala contexto del repo bajo demanda), `omna-security-posture` (revisión de seguridad con datos reales), `omna-design-check` (adjudica una decisión de diseño contra el charter del proyecto cliente vía `get_project_charter`) y `omna-coaching-mode` (coaching de cumplimiento sobre tu código sin commitear, razonado localmente contra la postura real del repo; el working code nunca sale de tu máquina).
- **Hook** `PreToolUse(Edit|Write)`: al editar código, recuerda consultar el contexto de OMNA antes de comprometer cambios.

## Instalación
1. Consigue una API-key de OMNA (Configuración → API Keys). Estréchala a tu(s) repo(s) — ver `Emisión de API-keys scopeadas` (bd j5e.6). La key decide qué ve el plugin; nunca ve fuera de su scope.
2. Exporta la key:
   ```bash
   export OMNA_API_KEY=op_xxxxxxxxxxxx
   ```
3. Instala el plugin en Claude Code (apunta a este directorio o al marketplace de OMNA cuando esté publicado).

## Garantías (charter)
- **Read-only**: ninguna tool escribe en OMNA ni envía tu working tree. Consultan lo ya ingerido en el workspace del cliente.
- **Aislamiento**: el alcance lo hereda la API-key de su principal y no auto-escala. Una key estrechada a un repo no ve el resto del workspace ni otros tenants.
- El dato del cliente nunca se copia fuera de su workspace; el plugin es una ventana de lectura.

## Próximamente
- Síntesis (crudo + lectura sintetizada) en cada tool (bd j5e.8).
- Modo de coacheo efímero sobre el código sin commitear (bd j5e.7).
