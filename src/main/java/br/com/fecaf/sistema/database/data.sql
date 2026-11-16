-- ============================================================
--  Sistema Automotivo — Modelo Físico (MySQL 8.x / InnoDB)
--  Script único com criação de tabelas e dados de teste.
-- ============================================================

CREATE DATABASE IF NOT EXISTS sistema_automotivo
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE sistema_automotivo;

-- ------------------------------------------------------------
-- Tabela: marca
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS marca (
    id    BIGINT      NOT NULL AUTO_INCREMENT,
    nome  VARCHAR(80) NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_marca_nome (nome)
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- Tabela: modelo
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS modelo (
    id       BIGINT      NOT NULL AUTO_INCREMENT,
    nome     VARCHAR(80) NOT NULL,
    marca_id BIGINT      NOT NULL,
    PRIMARY KEY (id),
    UNIQUE KEY uk_modelo_marca_nome (marca_id, nome),
    CONSTRAINT fk_modelo_marca
        FOREIGN KEY (marca_id) REFERENCES marca (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- Tabela: veiculo
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS veiculo (
    id            BIGINT        NOT NULL AUTO_INCREMENT,
    modelo_id     BIGINT        NOT NULL,
    ano           INT           NOT NULL,
    cor           VARCHAR(40)   NOT NULL,
    preco         DECIMAL(12,2) NOT NULL,
    quilometragem DECIMAL(10,2) NOT NULL,
    status        VARCHAR(20)   NOT NULL DEFAULT 'DISPONIVEL',
    foto_url      VARCHAR(255), 
    PRIMARY KEY (id),
    KEY idx_veiculo_status (status),
    KEY idx_veiculo_ano (ano),
    CONSTRAINT fk_veiculo_modelo
        FOREIGN KEY (modelo_id) REFERENCES modelo (id)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT ck_veiculo_preco_nao_negativa
        CHECK (preco >= 0),
    CONSTRAINT ck_veiculo_km_nao_negativa
        CHECK (quilometragem >= 0),
    CONSTRAINT ck_veiculo_ano_valido
        CHECK (ano BETWEEN 1900 AND 2200),
    CONSTRAINT ck_veiculo_status_valido
        CHECK (status IN ('DISPONIVEL', 'RESERVADO', 'VENDIDO', 'DESCONTINUADO'))
) ENGINE = InnoDB;

-- ============================================================
-- DADOS DE TESTE (Para o professor ver o sistema populado)
-- ============================================================

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