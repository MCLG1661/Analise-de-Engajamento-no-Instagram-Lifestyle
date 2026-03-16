// Descobrir clusters de hashtags usadas juntas
MATCH (u:User)-[:USES_HASHTAG]->(h1:Hashtag)
MATCH (u)-[:USES_HASHTAG]->(h2:Hashtag)
WHERE h1 <> h2 AND h1.tag < h2.tag
RETURN h1.tag AS Hashtag1,
       h2.tag AS Hashtag2,
       COUNT(DISTINCT u) AS UsuariosComuns
ORDER BY UsuariosComuns DESC
LIMIT 20;
