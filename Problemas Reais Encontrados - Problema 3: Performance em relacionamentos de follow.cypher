Solução: Criar índice composto

CREATE INDEX follows_index FOR ()-[r:FOLLOWS]-() ON (r.since);
