[DESENHE NO ARROWS.APP - https://arrows.app]

(:User {
    userId: string,
    username: string,
    fullName: string,
    bio: string,
    followers: integer,
    following: integer,
    posts: integer,
    location: string,
    engagementRate: float
})

(:Post {
    postId: string,
    type: string,  // 'photo', 'reel', 'story'
    avgLikes: integer,
    avgComments: integer,
    frequency: string
})

(:Category {
    name: string  // 'Moda', 'Viagem', 'Fitness', 'Comida', 'Beleza'
})

(:Hashtag {
    tag: string,
    frequency: integer
})

(:Location {
    city: string,
    country: string
})

// Relacionamentos
(:User)-[:POSTS_IN_CATEGORY]->(:Category)
(:User)-[:USES_HASHTAG {frequency: integer}]->(:Hashtag)
(:User)-[:BASED_IN]->(:Location)
(:User)-[:FOLLOWS {since: date}]->(:User)
(:User)-[:CREATED_CONTENT]->(:Post)
(:User)-[:INTERACTED_WITH {type: string, timestamp: datetime}]->(:Post)
(:Post)-[:FEATURED_IN]->(:Category)
(:Post)-[:TAGGED_WITH]->(:Hashtag)
