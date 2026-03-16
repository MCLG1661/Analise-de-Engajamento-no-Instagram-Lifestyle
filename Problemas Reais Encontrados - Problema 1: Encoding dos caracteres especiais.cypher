Solução:

// Adicionar no LOAD CSV
LOAD CSV WITH HEADERS FROM 'file:///instagram_clean.csv' AS row
WITH row, apoc.text.clean(row.Username) AS cleanUsername
