import pandas as pd
import numpy as np

# Carregar o dataset
df = pd.read_csv('instagram_usage_lifestyle.csv')

print("📊 Análise Inicial do Dataset")
print("="*50)
print(f"Total de registros: {len(df)}")
print(f"Colunas: {list(df.columns)}")
print("\n🎯 Distribuição por Categoria:")
print(df['Category'].value_counts())
print("\n📈 Estatísticas de Engajamento:")
print(df[['Followers', 'Avg_Likes', 'Avg_Comments', 'Engagement_Rate']].describe())

# Identificar valores nulos
print("\n⚠️ Valores nulos por coluna:")
print(df.isnull().sum())

# Criar versão limpa dos dados
df_clean = df.dropna(subset=['User_ID', 'Category'])  # Remove registros sem dados essenciais

# Salvar versão limpa
df_clean.to_csv('instagram_clean.csv', index=False)
print(f"\n✅ Dados limpos salvos: {len(df_clean)} registros")
