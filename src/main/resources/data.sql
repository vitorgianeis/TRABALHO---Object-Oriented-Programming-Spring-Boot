-- ============================================================
--  Dados de Teste (Para o professor ver o sistema populado)
-- ============================================================

-- Inserindo Marcas
INSERT IGNORE INTO marca (id, nome) VALUES 
(1, 'Toyota'), 
(2, 'Honda'), 
(3, 'Ford'),
(4, 'Renault'),
(5, 'Chevrolet');

-- Inserindo Modelos (Puxando o ID da marca)
INSERT IGNORE INTO modelo (id, nome, marca_id) VALUES 
(1, 'Corolla', 1), 
(2, 'Civic', 2), 
(3, 'Mustang', 3),
(4, 'Kardian', 4),
(5, 'Classic', 5);

-- Inserindo Veículos 
INSERT IGNORE INTO veiculo (modelo_id, ano, cor, preco, quilometragem, status, foto_url) VALUES 
(1, 2023, 'Prata', 150000.00, 0, 'DISPONIVEL', 'https://images.unsplash.com/photo-1550355291-bbee04a92027?auto=format&fit=crop&w=400&q=80'),
(2, 2022, 'Preto', 120000.00, 15000, 'DISPONIVEL', 'https://images.unsplash.com/photo-1533473359331-0135ef1b58bf?auto=format&fit=crop&w=400&q=80'),
(3, 2021, 'Vermelho', 250000.00, 8000, 'VENDIDO', 'https://images.unsplash.com/photo-1584345604476-8ec5e12e42dd?auto=format&fit=crop&w=400&q=80'),
(4, 2026, 'Azul', 100000.00, 0, 'DISPONIVEL', 'https://admin.cnnbrasil.com.br/wp-content/uploads/sites/12/2025/08/kardian-2026.jpeg?w=1200&h=900&crop=0&quality=90'),
(5, 2015, 'Prata', 30000.00, 50000, 'DISPONIVEL', 'https://quatrorodas.abril.com.br/wp-content/uploads/2016/11/5658c2af52657372afba439201_gm_classic_3-4_frente_04_06_141.jpeg?quality=70&strip=all');