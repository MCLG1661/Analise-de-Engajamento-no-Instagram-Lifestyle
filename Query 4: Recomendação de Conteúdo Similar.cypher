// Recomendar usuários baseado em categorias e hashtags similares
MATCH (me:User {username: '@fashion_ana'})
MATCH (me)-[:POSTS_IN_CATEGORY]->(c:Category)<-[:POSTS_IN_CATEGORY]-(similar:User)
WHERE me <> similar
OPTIONAL MATCH (me)-[:USES_HASHTAG]->(h:Hashtag)<-[:USES_HASHTAG]-(similar)
WITH similar, 
     COUNT(DISTINCT c) AS categoriasComuns,
     COUNT(DISTINCT h) AS hashtagsComuns,
     similar.followers AS relevancia
RETURN similar.username AS Recomendacao,
       similar.fullName AS Nome,
       similar.category AS Categoria,
       categoriasComuns,
       hashtagsComuns,
       relevancia
ORDER BY (categoriasComuns * 3 + hashtagsComuns * 2 + relevancia/10000) DESC
LIMIT 10;
