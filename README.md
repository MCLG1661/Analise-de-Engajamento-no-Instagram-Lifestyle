# Análise de Engajamento no Instagram Lifestyle

## 📑Contexto do Problema
Uma startup de análise de mídias sociais deseja criar um produto que ofereça insights sobre engajamento e conexões entre usuários do Instagram, focando em conteúdo de estilo de vida (lifestyle). O dataset instagram_usage_lifestyle.csv contém dados reais de interações, perfis e conteúdos relacionados a moda, viagens, fitness, comida e outros temas lifestyle.

## 🎯 INSIGHTS DE NEGÓCIO (O QUE DESCOBRIMOS)

- Cross-category Influencers: 23% dos influenciadores atuam em mais de uma categoria, principalmente Moda + Beleza
- Engajamento por Local: Usuários do Rio de Janeiro têm 15% mais engajamento que a média nacional
- Hashtags Poderosas: #lookdodia e #fitness geram 3x mais interações que outras hashtags
- Gap de Mercado: Categoria 'Sustentabilidade' tem poucos influenciadores mas alto engajamento (oportunidade!)
- Melhor Horário: Posts entre 19h-21h às quartas-feiras têm maior engajamento

## 📁 ESTRUTURA DO REPOSITÓRIO 

```
instagram-neo4j-project/
├── README.md
├── data/
│   ├── instagram_usage_lifestyle.csv
│   └── instagram_clean.csv
├── scripts/
│   ├── analyze_dataset.py
│   ├── load_instagram.cypher
│   └── generate_insights.py
├── queries/
│   ├── business_queries.cypher
│   ├── influencer_analysis.cypher
│   └── community_detection.cypher
├── prints/
│   ├── visao_geral.png
│   ├── cluster_moda.png
│   └── top_influenciadores.png
└── docs/
    ├── modelo_grafo.png
    └── arrows_model.json

``` 
