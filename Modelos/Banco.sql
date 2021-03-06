-- MySQL Script generated by MySQL Workbench
-- 11/25/16 15:03:51
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

-- -----------------------------------------------------
-- Schema escolafuturo
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema escolafuturo
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `escolafuturo` DEFAULT CHARACTER SET utf8 ;
USE `escolafuturo` ;

-- -----------------------------------------------------
-- Table `escolafuturo`.`disciplina`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`disciplina` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`disciplina` (
  `iddisciplina` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(10) NOT NULL,
  `nome` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`iddisciplina`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`professor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`professor` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`professor` (
  `idprofessor` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idprofessor`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`turma`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`turma` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`turma` (
  `idturma` INT UNSIGNED NOT NULL AUTO_INCREMENT,
  `disciplina_codigo` VARCHAR(10) NOT NULL,
  `professor_idprofessor` INT NOT NULL,
  `horario` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idturma`),
  INDEX `fk_turma_diciplina_idx` (`disciplina_codigo` ASC),
  INDEX `fk_turma_professor1_idx` (`professor_idprofessor` ASC),
  UNIQUE INDEX `un_turma` (`disciplina_codigo` ASC, `professor_idprofessor` ASC, `horario` ASC),
  CONSTRAINT `fk_turma_diciplina`
    FOREIGN KEY (`disciplina_codigo`)
    REFERENCES `escolafuturo`.`disciplina` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_professor1`
    FOREIGN KEY (`professor_idprofessor`)
    REFERENCES `escolafuturo`.`professor` (`idprofessor`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`aluno` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`aluno` (
  `matricula` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`matricula`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`funcionario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`funcionario` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`funcionario` (
  `idfuncionario` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(100) NOT NULL,
  `login` VARCHAR(15) NOT NULL,
  `senha` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`idfuncionario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`avaliacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`avaliacao` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`avaliacao` (
  `idavaliacao` INT NOT NULL AUTO_INCREMENT,
  `status` INT(1) NOT NULL,
  `turma_idturma` INT UNSIGNED NOT NULL,
  PRIMARY KEY (`idavaliacao`, `turma_idturma`),
  INDEX `fk_avaliacao_turma1_idx` (`turma_idturma` ASC),
  CONSTRAINT `fk_avaliacao_turma1`
    FOREIGN KEY (`turma_idturma`)
    REFERENCES `escolafuturo`.`turma` (`idturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`questao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`questao` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`questao` (
  `idquestao` INT NOT NULL AUTO_INCREMENT,
  `enunciado` VARCHAR(255) NOT NULL,
  `opcao1` VARCHAR(255) NOT NULL,
  `opcao2` VARCHAR(255) NOT NULL,
  `opcao3` VARCHAR(255) NOT NULL,
  `opcao4` VARCHAR(255) NOT NULL,
  `resposta` INT(1) NOT NULL,
  `disciplina_codigo` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`idquestao`),
  INDEX `fk_questao_diciplina1_idx` (`disciplina_codigo` ASC),
  CONSTRAINT `fk_questao_diciplina1`
    FOREIGN KEY (`disciplina_codigo`)
    REFERENCES `escolafuturo`.`disciplina` (`codigo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`questao_avaliacao`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`questao_avaliacao` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`questao_avaliacao` (
  `questao_idquestao` INT NOT NULL,
  `avaliacao_idavaliacao` INT NOT NULL,
  PRIMARY KEY (`questao_idquestao`, `avaliacao_idavaliacao`),
  INDEX `fk_questao_has_avaliacao_avaliacao1_idx` (`avaliacao_idavaliacao` ASC),
  INDEX `fk_questao_has_avaliacao_questao1_idx` (`questao_idquestao` ASC),
  CONSTRAINT `fk_questao_has_avaliacao_questao1`
    FOREIGN KEY (`questao_idquestao`)
    REFERENCES `escolafuturo`.`questao` (`idquestao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_questao_has_avaliacao_avaliacao1`
    FOREIGN KEY (`avaliacao_idavaliacao`)
    REFERENCES `escolafuturo`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`nota`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`nota` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`nota` (
  `avaliacao_idavaliacao` INT NOT NULL,
  `aluno_matricula` INT NOT NULL,
  `nota` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`avaliacao_idavaliacao`, `aluno_matricula`),
  INDEX `fk_avaliacao_has_aluno_aluno1_idx` (`aluno_matricula` ASC),
  INDEX `fk_avaliacao_has_aluno_avaliacao1_idx` (`avaliacao_idavaliacao` ASC),
  CONSTRAINT `fk_avaliacao_has_aluno_avaliacao1`
    FOREIGN KEY (`avaliacao_idavaliacao`)
    REFERENCES `escolafuturo`.`avaliacao` (`idavaliacao`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_avaliacao_has_aluno_aluno1`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `escolafuturo`.`aluno` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `escolafuturo`.`turma_aluno`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `escolafuturo`.`turma_aluno` ;

CREATE TABLE IF NOT EXISTS `escolafuturo`.`turma_aluno` (
  `turma_idturma` INT UNSIGNED NOT NULL,
  `aluno_matricula` INT NOT NULL,
  `disciplina` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`turma_idturma`, `aluno_matricula`),
  INDEX `fk_turma_has_aluno_aluno1_idx` (`aluno_matricula` ASC),
  INDEX `fk_turma_has_aluno_turma1_idx` (`turma_idturma` ASC),
  UNIQUE INDEX `un_turma` (`aluno_matricula` ASC, `disciplina` ASC),
  CONSTRAINT `fk_turma_has_aluno_turma1`
    FOREIGN KEY (`turma_idturma`)
    REFERENCES `escolafuturo`.`turma` (`idturma`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_turma_has_aluno_aluno1`
    FOREIGN KEY (`aluno_matricula`)
    REFERENCES `escolafuturo`.`aluno` (`matricula`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
