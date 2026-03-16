// ANTES DE COMEÇAR: Limpar banco (opcional)
MATCH (n) DETACH DELETE n;

// 1. CRIAR ÍNDICES PARA PERFORMANCE
CREATE INDEX user_id IF NOT EXISTS FOR (u:User) ON (u.userId);
CREATE INDEX user_username IF NOT EXISTS FOR (u:User) ON (u.username);
CREATE INDEX category_name IF NOT EXISTS FOR (c:Category) ON (c.name);
CREATE INDEX hashtag_name IF NOT EXISTS FOR (h:Hashtag) ON (h.tag);
CREATE INDEX location_city IF NOT EXISTS FOR (l:Location) ON (l.city);

// 2. CARREGAR USUÁRIOS E SUAS CATEGORIAS
LOAD CSV WITH HEADERS FROM 'file:///instagram_clean.csv' AS row
MERGE (u:User {userId: row.User_ID})
SET u.username = row.Username,
    u.fullName = row.Full_Name,
    u.bio = row.Bio,
    u.followers = toInteger(row.Followers),
    u.following = toInteger(row.Following),
    u.posts = toInteger(row.Posts),
    u.engagementRate = toFloat(row.Engagement_Rate)
WITH u, row

// Criar/associar categoria
MERGE (c:Category {name: row.Category})
MERGE (u)-[:POSTS_IN_CATEGORY]->(c)

// Processar localização
WITH u, row,
     split(row.Location, ',') AS locParts
MERGE (l:Location {
    city: trim(locParts[0]),
    country: CASE WHEN size(locParts) > 1 THEN trim(locParts[1]) ELSE 'Brasil' END
})
MERGE (u)-[:BASED_IN]->(l);

// 3. PROCESSAR HASHTAGS
LOAD CSV WITH HEADERS FROM 'file:///instagram_clean.csv' AS row
MATCH (u:User {userId: row.User_ID})
WITH u, split(row.Hashtags_Used, ' ') AS hashtags
UNWIND hashtags AS hashtag
WITH u, trim(hashtag) AS cleanHashtag
WHERE cleanHashtag STARTS WITH '#'
MERGE (h:Hashtag {tag: cleanHashtag})
MERGE (u)-[:USES_HASHTAG]->(h);

// 4. CRIAR NÓS DE POST (BASEADO NAS MÉDIAS)
LOAD CSV WITH HEADERS FROM 'file:///instagram_clean.csv' AS row
MATCH (u:User {userId: row.User_ID})
CREATE (p:Post {
    postId: row.User_ID + '_' + row.Content_Type + '_' + apoc.text.random(5),
    type: row.Content_Type,
    avgLikes: toInteger(row.Avg_Likes),
    avgComments: toInteger(row.Avg_Comments),
    frequency: row.Post_Frequency,
    createdAt: datetime()  // Data atual como placeholder
})
CREATE (u)-[:CREATED_CONTENT]->(p)
WITH p, row

// Associar post à categoria
MATCH (c:Category {name: row.Category})
CREATE (p)-[:FEATURED_IN]->(c);

// 5. CRIAR RELACIONAMENTOS DE FOLLOW (BASEADO EM SIMILARIDADE)
// Quem tem categorias similares provavelmente se segue
MATCH (u1:User)-[:POSTS_IN_CATEGORY]->(c:Category)<-[:POSTS_IN_CATEGORY]-(u2:User)
WHERE u1 <> u2
WITH u1, u2, COUNT(c) AS categoriesInCommon
WHERE categoriesInCommon >= 1  // Pelo menos uma categoria em comum
MERGE (u1)-[:FOLLOWS {
    since: date('2023-01-01'),  // Data aproximada
    strength: categoriesInCommon * 1.0 / 3  // Força da conexão
}]->(u2);

// 6. CRIAR INTERAÇÕES SIMULADAS (BASEADO EM ENGAGEMENT_RATE)
MATCH (u1:User)-[:FOLLOWS]->(u2:User)
MATCH (u2)-[:CREATED_CONTENT]->(p:Post)
WITH u1, p, u2.engagementRate AS er
WHERE rand() < er / 100  // Probabilidade baseada na taxa de engajamento
CREATE (u1)-[:INTERACTED_WITH {
    type: CASE 
        WHEN rand() < 0.7 THEN 'like'
        WHEN rand() < 0.9 THEN 'comment'
        ELSE 'share'
    END,
    timestamp: datetime() - duration({days: toInteger(rand() * 30)})
}]->(p);

// 7. CRIAR RELACIONAMENTO DE INFLUÊNCIA (BASEADO EM SEGUIDORES)
MATCH (u:User)
WHERE u.followers > 10000  // Micro-influenciadores
SET u:Influencer;

// Conectar influenciadores a seus nichos
MATCH (i:Influencer)-[:POSTS_IN_CATEGORY]->(c:Category)
WITH i, c, i.followers AS followers
ORDER BY followers DESC
WITH c, COLLECT(i)[0..5] AS topInfluencers
UNWIND topInfluencers AS influencer
MERGE (influencer)-[:TOP_INFLUENCER_IN]->(c);
