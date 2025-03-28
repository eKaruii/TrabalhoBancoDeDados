SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS RestauranteBD DEFAULT CHARACTER SET utf8;
USE RestauranteBD;

-- Tabela Cliente
CREATE TABLE IF NOT EXISTS Cliente (
  id_cliente INT AUTO_INCREMENT NOT NULL,
  nome_cliente VARCHAR(100)  NULL,
  endereco VARCHAR(200) NULL,
  CPF CHAR(20) UNIQUE,
  PRIMARY KEY (id_cliente)
) ENGINE = InnoDB;

-- Tabela Mesa
CREATE TABLE IF NOT EXISTS Mesa (
  numero_mesa TINYINT(2) ZEROFILL NOT NULL,
  PRIMARY KEY (numero_mesa)
) ENGINE = InnoDB;

-- Tabela Atendente
CREATE TABLE IF NOT EXISTS Atendente (
  matricula SMALLINT(3) zerofill NOT NULL,
  nome_atendente VARCHAR(100) NOT NULL,
  salario DECIMAL(10,2) NOT NULL,
  AtendenteSenior_matricula SMALLINT(3) zerofill NULL,
  PRIMARY KEY (matricula),
  FOREIGN KEY (AtendenteSenior_matricula)
    REFERENCES Atendente (matricula)
    ON DELETE SET NULL
    ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela Pedido
CREATE TABLE IF NOT EXISTS Pedido (
  numero_Pedido INT AUTO_INCREMENT NOT NULL,
  hora_inicio DATETIME NOT NULL,
  hora_fim DATETIME NULL,
  duracao_segundos INT NULL,
  Cliente_id INT NOT NULL,
  Mesa_numero TINYINT(2) ZEROFILL NOT NULL,
  Atendente_matricula SMALLINT(3) zerofill NOT NULL,
  PRIMARY KEY (numero_Pedido),
  FOREIGN KEY (Cliente_id) REFERENCES Cliente (id_cliente) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Mesa_numero) REFERENCES Mesa (numero_mesa) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Atendente_matricula) REFERENCES Atendente (matricula) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela Prato
CREATE TABLE IF NOT EXISTS Prato (
  codigo_prato INT AUTO_INCREMENT NOT NULL,
  nome_prato VARCHAR(100) NOT NULL,
  preco_prato DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (codigo_prato)
) ENGINE = InnoDB;

-- Tabela Bebida
CREATE TABLE IF NOT EXISTS Bebida (
  codigo_bebida INT AUTO_INCREMENT NOT NULL,
  nome_bebida VARCHAR(100) NOT NULL,
  preco_bebida DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (codigo_bebida)
) ENGINE = InnoDB;

-- Tabela de relacionamento entre Prato e Pedido (N:N)
CREATE TABLE IF NOT EXISTS Prato_has_Pedido (
  Prato_codigo_prato INT NOT NULL,
  Pedido_numero_Pedido INT NOT NULL,
  PRIMARY KEY (Prato_codigo_prato, Pedido_numero_Pedido),
  FOREIGN KEY (Prato_codigo_prato) REFERENCES Prato (codigo_prato) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Pedido_numero_Pedido) REFERENCES Pedido (numero_Pedido) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela de relacionamento entre Bebida e Pedido (N:N)
CREATE TABLE IF NOT EXISTS Bebida_has_Pedido (
  Bebida_codigo_bebida INT NOT NULL,
  Pedido_numero_Pedido INT NOT NULL,
  PRIMARY KEY (Bebida_codigo_bebida, Pedido_numero_Pedido),
  FOREIGN KEY (Bebida_codigo_bebida) REFERENCES Bebida (codigo_bebida) ON DELETE CASCADE ON UPDATE CASCADE,
  FOREIGN KEY (Pedido_numero_Pedido) REFERENCES Pedido (numero_Pedido) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Tabela Telefone 
CREATE TABLE IF NOT EXISTS Telefone (
  numero_telefone VARCHAR(15) NOT NULL,
  Atendente_matricula SMALLINT(3) zerofill NOT NULL,
  PRIMARY KEY (numero_telefone, Atendente_matricula),
  FOREIGN KEY (Atendente_matricula) REFERENCES Atendente (matricula) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

-- Triggers --

DELIMITER $$ 
DELIMITER $$ 
CREATE TRIGGER antes_pedido_insert
BEFORE INSERT ON Pedido
FOR EACH ROW
BEGIN
    IF NEW.hora_fim IS NOT NULL THEN
        SET NEW.duracao_segundos = TIMESTAMPDIFF(SECOND, NEW.hora_inicio, NEW.hora_fim);
    END IF;
END $$


DELIMITER $$ 
CREATE TRIGGER antes_pedido_update
BEFORE UPDATE ON Pedido
FOR EACH ROW
BEGIN
    -- Verifica se hora_fim foi alterada e está preenchida
    IF NEW.hora_fim IS NOT NULL THEN
        SET NEW.duracao_segundos = TIMESTAMPDIFF(SECOND, NEW.hora_inicio, NEW.hora_fim);
    END IF;
END $$

DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
