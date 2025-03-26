-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cliente` (
  `id_cliente` INT NOT NULL,
  `nome_cliente` VARCHAR(100) NULL,
  `endereco` VARCHAR(200) NULL,
  `CPF` VARCHAR(15) NULL,
  PRIMARY KEY (`id_cliente`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Mesa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Mesa` (
  `numero_mesa` INT(2) NOT NULL,
  PRIMARY KEY (`numero_mesa`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Atendente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Atendente` (
  `matricula` INT(3) NOT NULL,
  `nome_atendente` VARCHAR(100) NOT NULL,
  `salario` DECIMAL(5,2) NOT NULL,
  `AtendenteSenior_matricula` INT(3) NULL,
  PRIMARY KEY (`matricula`),
  INDEX `fk_Atendente_Atendente_idx` (`AtendenteSenior_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Atendente_Atendente`
    FOREIGN KEY (`AtendenteSenior_matricula`)
    REFERENCES `mydb`.`Atendente` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pedido` (
  `numero_Pedido` INT NOT NULL AUTO_INCREMENT,
  `hora_inicio` DATETIME NOT NULL,
  `hora_fim` DATETIME NOT NULL,
  `Duração_segundos` INT NOT NULL,
  `Cliente_id` INT NOT NULL,
  `Mesa_numero` INT(2) NOT NULL,
  `Atendente_matricula` INT(3) NOT NULL,
  PRIMARY KEY (`numero_Pedido`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_id` ASC) VISIBLE,
  INDEX `fk_Pedido_Mesa1_idx` (`Mesa_numero` ASC) VISIBLE,
  INDEX `fk_Pedido_Atendente1_idx` (`Atendente_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_id`)
    REFERENCES `mydb`.`Cliente` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Mesa1`
    FOREIGN KEY (`Mesa_numero`)
    REFERENCES `mydb`.`Mesa` (`numero_mesa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Pedido_Atendente1`
    FOREIGN KEY (`Atendente_matricula`)
    REFERENCES `mydb`.`Atendente` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prato`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prato` (
  `codigo_prato` INT NOT NULL,
  `nome_prato` VARCHAR(100) NOT NULL,
  `preco_prato` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`codigo_prato`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bebida`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bebida` (
  `codigo_bebida` INT NOT NULL,
  `nome_bebida` VARCHAR(4100) NOT NULL,
  `preco_bebida` DECIMAL(4,2) NOT NULL,
  PRIMARY KEY (`codigo_bebida`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Prato_has_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Prato_has_Pedido` (
  `Prato_codigo_prato` INT NOT NULL,
  `Pedido_numero_Pedido` INT NOT NULL,
  INDEX `fk_Prato_has_Pedido_Pedido1_idx` (`Pedido_numero_Pedido` ASC) VISIBLE,
  INDEX `fk_Prato_has_Pedido_Prato1_idx` (`Prato_codigo_prato` ASC) VISIBLE,
  PRIMARY KEY (`Prato_codigo_prato`, `Pedido_numero_Pedido`),
  CONSTRAINT `fk_Prato_has_Pedido_Prato1`
    FOREIGN KEY (`Prato_codigo_prato`)
    REFERENCES `mydb`.`Prato` (`codigo_prato`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Prato_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_numero_Pedido`)
    REFERENCES `mydb`.`Pedido` (`numero_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Bebida_has_Pedido`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Bebida_has_Pedido` (
  `Bebida_codigo_bebida` INT NOT NULL,
  `Pedido_numero_Pedido` INT NOT NULL,
  PRIMARY KEY (`Bebida_codigo_bebida`, `Pedido_numero_Pedido`),
  INDEX `fk_Bebida_has_Pedido_Pedido1_idx` (`Pedido_numero_Pedido` ASC) VISIBLE,
  INDEX `fk_Bebida_has_Pedido_Bebida1_idx` (`Bebida_codigo_bebida` ASC) VISIBLE,
  CONSTRAINT `fk_Bebida_has_Pedido_Bebida1`
    FOREIGN KEY (`Bebida_codigo_bebida`)
    REFERENCES `mydb`.`Bebida` (`codigo_bebida`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Bebida_has_Pedido_Pedido1`
    FOREIGN KEY (`Pedido_numero_Pedido`)
    REFERENCES `mydb`.`Pedido` (`numero_Pedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Telefone`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Telefone` (
  `numero_telefone` INT NOT NULL,
  `Atendente_matricula` INT(3) NOT NULL,
  PRIMARY KEY (`numero_telefone`, `Atendente_matricula`),
  INDEX `fk_Telefone_Atendente1_idx` (`Atendente_matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Telefone_Atendente1`
    FOREIGN KEY (`Atendente_matricula`)
    REFERENCES `mydb`.`Atendente` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
