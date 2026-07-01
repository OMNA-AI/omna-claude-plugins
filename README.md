# OMNA — Claude Code plugins

Marketplace público de plugins de Claude Code de OMNA (modelo descentralizado).
El **acceso a datos** lo gatea tu **API-key de OMNA** (scopeada, por-usuario), no el repo.

## Instalar
```
export OMNA_API_KEY=op_…          # tu key de OMNA (pídela a OMNA)
```
En Claude Code:
```
/plugin marketplace add OMNA-AI/omna-claude-plugins
/plugin install omna-brain@omna
/mcp     # verifica que "omna-brain" esté conectado
```

## Qué trae el plugin `omna-brain`
Cerebro técnico de OMNA en tu editor (solo-lectura, scope-aware por la key):
postura de seguridad, hallazgos de vulnerabilidades, grafo de símbolos, charter
del proyecto, y **recomendaciones** de mejora del código (`get_recommendations`).
