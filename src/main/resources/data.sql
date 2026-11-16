-- ============================================================
--  Dados de Teste (Só insere se o ID específico não existir)
-- ============================================================

-- Inserindo Marcas
INSERT INTO marca (id, nome) SELECT 1, 'Toyota' WHERE NOT EXISTS (SELECT 1 FROM marca WHERE id = 1);
INSERT INTO marca (id, nome) SELECT 2, 'Honda' WHERE NOT EXISTS (SELECT 1 FROM marca WHERE id = 2);
INSERT INTO marca (id, nome) SELECT 3, 'Ford' WHERE NOT EXISTS (SELECT 1 FROM marca WHERE id = 3);
INSERT INTO marca (id, nome) SELECT 4, 'Renault' WHERE NOT EXISTS (SELECT 1 FROM marca WHERE id = 4);
INSERT INTO marca (id, nome) SELECT 5, 'Chevrolet' WHERE NOT EXISTS (SELECT 1 FROM marca WHERE id = 5);

-- Inserindo Modelos
INSERT INTO modelo (id, nome, marca_id) SELECT 1, 'Corolla', 1 WHERE NOT EXISTS (SELECT 1 FROM modelo WHERE id = 1);
INSERT INTO modelo (id, nome, marca_id) SELECT 2, 'Civic', 2 WHERE NOT EXISTS (SELECT 1 FROM modelo WHERE id = 2);
INSERT INTO modelo (id, nome, marca_id) SELECT 3, 'Mustang', 3 WHERE NOT EXISTS (SELECT 1 FROM modelo WHERE id = 3);
INSERT INTO modelo (id, nome, marca_id) SELECT 4, 'Kardian', 4 WHERE NOT EXISTS (SELECT 1 FROM modelo WHERE id = 4);
INSERT INTO modelo (id, nome, marca_id) SELECT 5, 'Classic', 5 WHERE NOT EXISTS (SELECT 1 FROM modelo WHERE id = 5);

-- Inserindo Veículos
INSERT INTO veiculo (id, modelo_id, ano, cor, preco, quilometragem, status, foto_url) 
SELECT 1, 1, 2023, 'Prata', 150000.00, 0, 'DISPONIVEL', 'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=400&q=80' WHERE NOT EXISTS (SELECT 1 FROM veiculo WHERE id = 1);

INSERT INTO veiculo (id, modelo_id, ano, cor, preco, quilometragem, status, foto_url) 
SELECT 2, 2, 2022, 'Preto', 120000.00, 15000, 'DISPONIVEL', 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=400&q=80' WHERE NOT EXISTS (SELECT 1 FROM veiculo WHERE id = 2);

INSERT INTO veiculo (id, modelo_id, ano, cor, preco, quilometragem, status, foto_url) 
SELECT 3, 3, 2021, 'Vermelho', 250000.00, 8000, 'VENDIDO', 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?auto=format&fit=crop&w=400&q=80' WHERE NOT EXISTS (SELECT 1 FROM veiculo WHERE id = 3);

INSERT INTO veiculo (id, modelo_id, ano, cor, preco, quilometragem, status, foto_url) 
SELECT 4, 4, 2026, 'Azul', 100000.00, 0, 'DISPONIVEL', 'https://admin.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/08/kardian-2026.jpeg?w=1200&h=900&crop=0&quality=90' WHERE NOT EXISTS (SELECT 1 FROM veiculo WHERE id = 4);

INSERT INTO veiculo (id, modelo_id, ano, cor, preco, quilometragem, status, foto_url) 
SELECT 5, 5, 2015, 'Prata', 30000.00, 50000, 'DISPONIVEL', 'https://quatrorodas.abril.com.br/wp-content/uploads/2016/11/5658c2af52657372afba439201_gm_classic_3-4_frente_04_06_141.jpeg?quality=70&strip=all' WHERE NOT EXISTS (SELECT 1 FROM veiculo WHERE id = 5);