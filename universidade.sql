SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE SCHEMA IF NOT EXISTS UniversidadeBD DEFAULT CHARACTER SET utf8;
USE UniversidadeBD;

CREATE TABLE IF NOT EXISTS Professor (
  Matricula INT(4) ZEROFILL NOT NULL,
  Email VARCHAR(256) NOT NULL UNIQUE,
  Nome VARCHAR(200) NOT NULL,
  Coordenador_Matricula INT(4) ZEROFILL NULL,
  PRIMARY KEY (Matricula),
  FOREIGN KEY (Coordenador_Matricula)
    REFERENCES Professor (Matricula)
    ON DELETE SET NULL  -- Se o coordenador for excluído, a referência será removida.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Curso (
  Codigo INT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  CargaHoraria INT NOT NULL DEFAULT 3600 CHECK (CargaHoraria = 3600),
  Professor_Matricula INT(4) ZEROFILL NOT NULL,
  PRIMARY KEY (Codigo),
  FOREIGN KEY (Professor_Matricula)
    REFERENCES Professor (Matricula)
    ON DELETE cascade  -- Se o professor for excluído, o curso perderá a referência.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Materia (
  Codigo INT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  CargaHoraria INT NOT NULL CHECK(CargaHoraria >= 40),
  PRIMARY KEY (Codigo)
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Disciplina (
  Codigo INT NOT NULL,
  Nome VARCHAR(100) NOT NULL,
  Semestre SMALLINT NOT NULL,
  Vagas INT NOT NULL CHECK(Vagas <= 60),
  Materia_Codigo INT NOT NULL,
  Professor_Matricula INT(4) ZEROFILL NOT NULL,
  PRIMARY KEY (Codigo, Materia_Codigo, Professor_Matricula),
  FOREIGN KEY (Materia_Codigo)
    REFERENCES Materia (Codigo)
    ON DELETE CASCADE  -- Se a matéria for excluída, a disciplina perde a referência.
    ON UPDATE CASCADE,
  FOREIGN KEY (Professor_Matricula)
    REFERENCES Professor (Matricula)
    ON DELETE CASCADE  -- Se o professor for excluído, a disciplina perde a referência.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Aluno (
  Matricula INT NOT NULL,
  Nome VARCHAR(200) NOT NULL,
  Telefone VARCHAR(20) NOT NULL,
  Endereco VARCHAR(250) NOT NULL,
  Curso_Codigo INT NULL,
  PRIMARY KEY (Matricula),
  FOREIGN KEY (Curso_Codigo)
    REFERENCES Curso (Codigo)
    ON DELETE CASCADE -- Se o curso for excluído, o aluno perde a referência.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Materia_has_Curso (
  Materia_Codigo INT NOT NULL,
  Curso_Codigo INT NOT NULL,
  PRIMARY KEY (Materia_Codigo, Curso_Codigo),
  FOREIGN KEY (Materia_Codigo)
    REFERENCES Materia (Codigo)
    ON DELETE CASCADE   -- Se a matéria for excluída, a relação com o curso também será removida.
    ON UPDATE CASCADE,
  FOREIGN KEY (Curso_Codigo)
    REFERENCES Curso (Codigo)
    ON DELETE CASCADE   -- Se o curso for excluído, a relação com a matéria também será removida.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Disciplina_has_Aluno (
  Disciplina_Codigo INT NOT NULL,
  Disciplina_Materia_Codigo INT NOT NULL,
  Disciplina_Professor_Matricula INT(4) ZEROFILL NOT NULL,
  Aluno_Matricula INT NOT NULL,
  PRIMARY KEY (Disciplina_Codigo, Disciplina_Materia_Codigo, Disciplina_Professor_Matricula, Aluno_Matricula),
  FOREIGN KEY (Disciplina_Codigo, Disciplina_Materia_Codigo, Disciplina_Professor_Matricula)
    REFERENCES Disciplina (Codigo, Materia_Codigo, Professor_Matricula)
    ON DELETE CASCADE   -- Se a disciplina for excluída, a associação com o aluno será removida.
    ON UPDATE CASCADE,
  FOREIGN KEY (Aluno_Matricula)
    REFERENCES Aluno (Matricula)
    ON DELETE CASCADE   -- Se o aluno for excluído, a associação com a disciplina será removida.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE IF NOT EXISTS Email (
  EnderecoEmail VARCHAR(256) NOT NULL,
  Aluno_Matricula INT NOT NULL,
  PRIMARY KEY (EnderecoEmail),
  FOREIGN KEY (Aluno_Matricula)
    REFERENCES Aluno (Matricula)
    ON DELETE CASCADE   -- Se o aluno for excluído, o email associado será removido.
    ON UPDATE CASCADE
) ENGINE = InnoDB;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
