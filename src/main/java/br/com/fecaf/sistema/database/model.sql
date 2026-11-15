

CREATE DATABASE IF NOT EXISTS sistema_automotivo
    DEFAULT CHARACTER SET utf8mb4
    DEFAULT COLLATE utf8mb4_0900_ai_ci;

USE sistema_automotivo;

-- ------------------------------------------------------------
-- Tabela: marca (1,N) modelos
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS marca (
    id    BIGINT      NOT NULL AUTO_INCREMENT,
    nome  VARCHAR(80) NOT NULL,
    PRIMARY KEY (id),
    -- nome de marca duplicado não é permitido (case-insensitive)
    UNIQUE KEY uk_marca_nome (nome)
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- Tabela: modelo (N,1) marca — e (1,N) veiculos
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS modelo (
    id       BIGINT      NOT NULL AUTO_INCREMENT,
    nome     VARCHAR(80) NOT NULL,
    marca_id BIGINT      NOT NULL,
    PRIMARY KEY (id),
    -- mesmo nome de modelo pode existir em marcas diferentes,
    -- mas não duas vezes na mesma marca
    UNIQUE KEY uk_modelo_marca_nome (marca_id, nome),
    CONSTRAINT fk_modelo_marca
        FOREIGN KEY (marca_id) REFERENCES marca (id)
        ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE = InnoDB;

-- ------------------------------------------------------------
-- Tabela: veiculo (N,1) modelo
-- A marca do veículo é derivada: veiculo → modelo → marca
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS veiculo (
    id            BIGINT        NOT NULL AUTO_INCREMENT,
    modelo_id     BIGINT        NOT NULL,
    ano           INT           NOT NULL,
    cor           VARCHAR(40)   NOT NULL,
    preco         DECIMAL(12,2) NOT NULL,
    quilometragem DECIMAL(10,2) NOT NULL,
    status        VARCHAR(20)   NOT NULL DEFAULT 'DISPONIVEL',
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
