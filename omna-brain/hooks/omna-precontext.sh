#!/usr/bin/env bash
# PreToolUse(Edit|Write) — patrón proactivo del plugin OMNA (bd j5e.5).
# Si el archivo a editar es código, inyecta un recordatorio para consultar
# el contexto del cerebro técnico de OMNA ANTES de tocarlo. No bloquea, no
# llama a la red: solo añade contexto (additionalContext). El pull real lo
# hace el agente vía las tools del server omna-brain.
set -euo pipefail

input=$(cat)
fp=$(printf '%s' "$input" | jq -r '.tool_input.file_path // empty' 2>/dev/null || true)

case "$fp" in
  *.ts|*.tsx|*.js|*.jsx|*.py|*.go|*.rs|*.java|*.rb|*.php|*.c|*.cpp|*.cs|*.kt|*.swift)
    base=${fp##*/}
    msg="OMNA: vas a editar \`$base\` (código). Antes de comprometer cambios, considera consultar el cerebro técnico de OMNA — get_code_posture (postura+tendencia), get_security_findings (vulnerabilidades), get_code_symbol (símbolo+callers) — para no romper algo que ya conoce. Solo-lectura, scope-aware."
    jq -nc --arg m "$msg" '{hookSpecificOutput:{hookEventName:"PreToolUse",additionalContext:$m}}'
    ;;
  *)
    : # no es código → sin contexto extra
    ;;
esac
exit 0
