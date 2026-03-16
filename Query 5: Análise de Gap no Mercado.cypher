// Encontrar categorias com poucos influenciadores mas alto engajamento
MATCH (c:Category)<-[:POSTS_IN_CATEGORY]-(u:User)
WITH c, 
     COUNT(u) AS totalInfluenciadores,
     AVG(u.engagementRate) AS mediaEngajamento,
     AVG(u.followers) AS mediaSeguidores
WHERE totalInfluenciadores < 10 AND mediaEngajamento > 4.0
RETURN c.name AS NichoOportunidade,
       totalInfluenciadores,
       round(mediaEngajamento, 2) AS mediaEngajamento,
       round(mediaSeguidores, 0) AS mediaSeguidores,
       '🔥 Oportunidade!' AS Status
ORDER BY mediaEngajamento DESC;
