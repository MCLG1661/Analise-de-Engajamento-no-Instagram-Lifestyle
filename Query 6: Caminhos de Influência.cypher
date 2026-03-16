// Mapear como a influência se propaga entre categorias
MATCH path = (c1:Category)<-[:POSTS_IN_CATEGORY]-(u1:User)
             -[:FOLLOWS]->(u2:User)
             -[:POSTS_IN_CATEGORY]->(c2:Category)
WHERE c1 <> c2
RETURN c1.name AS Origem,
       c2.name AS Destino,
       COUNT(DISTINCT u1) AS influenciadores,
       COUNT(DISTINCT u2) AS seguidores,
       round(COUNT(DISTINCT u2) * 1.0 / COUNT(DISTINCT u1), 2) AS taxaPropagacao
ORDER BY taxaPropagacao DESC;
