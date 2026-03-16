// Análise geográfica do engajamento
MATCH (u:User)-[:BASED_IN]->(l:Location)
RETURN l.city AS Cidade,
       COUNT(u) AS TotalUsuarios,
       AVG(u.followers) AS MediaSeguidores,
       AVG(u.engagementRate) AS MediaEngajamento,
       COLLECT(DISTINCT u.username)[0..3] AS TopUsuarios
ORDER BY MediaSeguidores DESC;
