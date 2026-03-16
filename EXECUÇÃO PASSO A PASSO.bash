# 1. Iniciar Neo4j com Docker
docker run -d \
  --name neo4j-instagram \
  -p 7474:7474 -p 7687:7687 \
  -e NEO4J_AUTH=neo4j/instagram123 \
  -e NEO4J_PLUGINS='["apoc", "graph-data-science"]' \
  -v $(pwd)/data:/var/lib/neo4j/import \
  neo4j:latest

# 2. Preparar os dados
mkdir -p data
cp instagram_usage_lifestyle.csv data/
python scripts/analyze_dataset.py

# 3. Copiar dados limpos para o container
docker cp instagram_clean.csv neo4j-instagram:/var/lib/neo4j/import/

# 4. Conectar ao Neo4j Browser
# Abra http://localhost:7474
# Login: neo4j / instagram123

# 5. Executar script de carga
# Cole o conteúdo do load_instagram.cypher no console

# 6. Verificar carga
MATCH (n) RETURN COUNT(n) AS TotalNos;
MATCH ()-[r]->() RETURN COUNT(r) AS TotalRelacionamentos;
