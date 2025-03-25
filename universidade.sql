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
-- Table `mydb`.`Professor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Professor` (
  `Matricula` INT NOT NULL,
  `Email` VARCHAR(256) NOT NULL,
  `Nome` VARCHAR(200) NOT NULL,
  `Coordenador_Matricula` INT NULL,
  PRIMARY KEY (`Matricula`),
  INDEX `fk_Professor_Professor1_idx` (`Coordenador_Matricula` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE,
  CONSTRAINT `fk_Professor_Professor1`
    FOREIGN KEY (`Coordenador_Matricula`)
    REFERENCES `mydb`.`Professor` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Curso` (
  `Codigo` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `CargaHoraria` INT NOT NULL,
  `Professor_Matricula` INT NOT NULL,
  PRIMARY KEY (`Codigo`),
  INDEX `fk_Curso_Professor1_idx` (`Professor_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Curso_Professor1`
    FOREIGN KEY (`Professor_Matricula`)
    REFERENCES `mydb`.`Professor` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Materia` (
  `Codigo` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `CargaHoraria` INT NOT NULL,
  PRIMARY KEY (`Codigo`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diciplina`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diciplina` (
  `Codigo` INT NOT NULL,
  `Nome` VARCHAR(100) NOT NULL,
  `Semestre` SMALLINT(2) NOT NULL,
  `Vagas` INT(2) NOT NULL,
  `Materia_Codigo` INT NOT NULL,
  `Professor_Matricula` INT NOT NULL,
  PRIMARY KEY (`Codigo`, `Materia_Codigo`, `Professor_Matricula`),
  INDEX `fk_Diciplina_Materia1_idx` (`Materia_Codigo` ASC) VISIBLE,
  INDEX `fk_Diciplina_Professor1_idx` (`Professor_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Diciplina_Materia1`
    FOREIGN KEY (`Materia_Codigo`)
    REFERENCES `mydb`.`Materia` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diciplina_Professor1`
    FOREIGN KEY (`Professor_Matricula`)
    REFERENCES `mydb`.`Professor` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Aluno` (
  `Matricula` INT NOT NULL,
  `Nome` VARCHAR(200) NOT NULL,
  `Telefone` VARCHAR(20) NOT NULL,
  `Endereco` VARCHAR(250) NOT NULL,
  `Curso_Codigo` INT NULL,
  PRIMARY KEY (`Matricula`),
  INDEX `fk_Aluno_Curso1_idx` (`Curso_Codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Aluno_Curso1`
    FOREIGN KEY (`Curso_Codigo`)
    REFERENCES `mydb`.`Curso` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Materia_has_Curso`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Materia_has_Curso` (
  `Materia_Codigo` INT NOT NULL,
  `Curso_Codigo` INT NOT NULL,
  PRIMARY KEY (`Materia_Codigo`, `Curso_Codigo`),
  INDEX `fk_Materia_has_Curso_Curso1_idx` (`Curso_Codigo` ASC) VISIBLE,
  INDEX `fk_Materia_has_Curso_Materia_idx` (`Materia_Codigo` ASC) VISIBLE,
  CONSTRAINT `fk_Materia_has_Curso_Materia`
    FOREIGN KEY (`Materia_Codigo`)
    REFERENCES `mydb`.`Materia` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Materia_has_Curso_Curso1`
    FOREIGN KEY (`Curso_Codigo`)
    REFERENCES `mydb`.`Curso` (`Codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Diciplina_has_Aluno`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Diciplina_has_Aluno` (
  `Diciplina_Codigo` INT NOT NULL,
  `Diciplina_Materia_Codigo` INT NOT NULL,
  `Diciplina_Professor_Matricula` INT NOT NULL,
  `Aluno_Matricula` INT NOT NULL,
  PRIMARY KEY (`Diciplina_Codigo`, `Diciplina_Materia_Codigo`, `Diciplina_Professor_Matricula`, `Aluno_Matricula`),
  INDEX `fk_Diciplina_has_Aluno_Aluno1_idx` (`Aluno_Matricula` ASC) VISIBLE,
  INDEX `fk_Diciplina_has_Aluno_Diciplina1_idx` (`Diciplina_Codigo` ASC, `Diciplina_Materia_Codigo` ASC, `Diciplina_Professor_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Diciplina_has_Aluno_Diciplina1`
    FOREIGN KEY (`Diciplina_Codigo` , `Diciplina_Materia_Codigo` , `Diciplina_Professor_Matricula`)
    REFERENCES `mydb`.`Diciplina` (`Codigo` , `Materia_Codigo` , `Professor_Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Diciplina_has_Aluno_Aluno1`
    FOREIGN KEY (`Aluno_Matricula`)
    REFERENCES `mydb`.`Aluno` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Email`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Email` (
  `EnderecoEmail` VARCHAR(256) NOT NULL,
  `Aluno_Matricula` INT NOT NULL,
  PRIMARY KEY (`EnderecoEmail`),
  INDEX `fk_Email_Aluno1_idx` (`Aluno_Matricula` ASC) VISIBLE,
  CONSTRAINT `fk_Email_Aluno1`
    FOREIGN KEY (`Aluno_Matricula`)
    REFERENCES `mydb`.`Aluno` (`Matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
