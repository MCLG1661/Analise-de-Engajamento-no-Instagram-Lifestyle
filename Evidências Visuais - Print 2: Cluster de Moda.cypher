MATCH (c:Category {name: 'Moda'})<-[:POSTS_IN_CATEGORY]-(u:User)
OPTIONAL MATCH (u)-[:USES_HASHTAG]->(h:Hashtag)
RETURN u, h LIMIT 50;
