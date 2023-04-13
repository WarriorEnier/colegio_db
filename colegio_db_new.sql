-- MySQL Script generated by MySQL Workbench
-- Wed Apr 12 18:18:44 2023
-- Model: New Model    Version: 1.0
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
-- Table `mydb`.`Materias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Materias` (
  `materia_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NULL,
  PRIMARY KEY (`materia_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`contactos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`contactos` (
  `contacto_id` INT NOT NULL AUTO_INCREMENT,
  `email` VARCHAR(100) NOT NULL,
  `direccion` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`contacto_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `usuario_id` INT NOT NULL AUTO_INCREMENT,
  `nombres` VARCHAR(45) NOT NULL,
  `apellidos` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATE NOT NULL,
  `genero` CHAR(1) NOT NULL,
  `perfil` VARCHAR(10) NOT NULL,
  `contacto_id` INT NOT NULL,
  `identificacion` VARCHAR(45) NOT NULL,
  `pass` VARCHAR(45) NOT NULL,
  `activo` TINYINT(1) NULL DEFAULT 1,
  PRIMARY KEY (`usuario_id`),
  INDEX `contacto_id_idx` (`contacto_id` ASC) VISIBLE,
  UNIQUE INDEX `identificacion_UNIQUE` (`identificacion` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_contacto`
    FOREIGN KEY (`contacto_id`)
    REFERENCES `mydb`.`contactos` (`contacto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Grados`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Grados` (
  `grado_id` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(45) NOT NULL,
  `paralelo` VARCHAR(5) NOT NULL,
  `num_salon` VARCHAR(5) NOT NULL,
  `dir_grupo` INT NOT NULL,
  PRIMARY KEY (`grado_id`),
  INDEX `dir_grupo_idx` (`dir_grupo` ASC) VISIBLE,
  CONSTRAINT `fk_grado_usuario`
    FOREIGN KEY (`dir_grupo`)
    REFERENCES `mydb`.`Usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Franja_Hora`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Franja_Hora` (
  `franja_hora_id` INT NOT NULL,
  `inicio` TIME NOT NULL,
  `finaliza` TIME NOT NULL,
  PRIMARY KEY (`franja_hora_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`usuario_x_materia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuario_x_materia` (
  `usuario_x_materia_id` INT NOT NULL DEFAULT 1,
  `materia_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`usuario_x_materia_id`),
  INDEX `materia_id_idx` (`materia_id` ASC) VISIBLE,
  INDEX `usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_usuario_materia_materia`
    FOREIGN KEY (`materia_id`)
    REFERENCES `mydb`.`Materias` (`materia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuario_materia_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`Usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Horarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Horarios` (
  `horario_id` INT NOT NULL AUTO_INCREMENT,
  `dia` VARCHAR(10) NOT NULL,
  `grado_id` INT NOT NULL,
  `franja_hora_id` INT NOT NULL,
  `user_materia_id` INT NOT NULL,
  PRIMARY KEY (`horario_id`),
  INDEX `grado_id_idx` (`grado_id` ASC) VISIBLE,
  INDEX `fk_horario_franja_hora_idx` (`franja_hora_id` ASC) VISIBLE,
  INDEX `fk_horario_user_materia_idx` (`user_materia_id` ASC) VISIBLE,
  CONSTRAINT `fk_horario_grado`
    FOREIGN KEY (`grado_id`)
    REFERENCES `mydb`.`Grados` (`grado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_franja_hora`
    FOREIGN KEY (`franja_hora_id`)
    REFERENCES `mydb`.`Franja_Hora` (`franja_hora_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_horario_user_materia`
    FOREIGN KEY (`user_materia_id`)
    REFERENCES `mydb`.`usuario_x_materia` (`usuario_x_materia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`indicadores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`indicadores` (
  `indicador_id` INT NOT NULL AUTO_INCREMENT,
  `indicador` VARCHAR(300) NULL,
  `user_materia_id` INT NOT NULL,
  `periodo` CHAR(1) NOT NULL,
  PRIMARY KEY (`indicador_id`),
  INDEX `fk_indicador_user_materia_idx` (`user_materia_id` ASC) VISIBLE,
  CONSTRAINT `fk_indicador_user_materia`
    FOREIGN KEY (`user_materia_id`)
    REFERENCES `mydb`.`usuario_x_materia` (`usuario_x_materia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notas_1`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notas_1` (
  `nota_1_id` INT NOT NULL AUTO_INCREMENT,
  `calificacion` DOUBLE NULL,
  `indicador_id` INT NOT NULL,
  PRIMARY KEY (`nota_1_id`),
  INDEX `indicador_id_idx` (`indicador_id` ASC) VISIBLE,
  CONSTRAINT `fk_nota_1_indicador`
    FOREIGN KEY (`indicador_id`)
    REFERENCES `mydb`.`indicadores` (`indicador_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notas_2`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notas_2` (
  `nota_2_id` INT NOT NULL AUTO_INCREMENT,
  `calificacion` DOUBLE NULL,
  `indicador_id` INT NOT NULL,
  PRIMARY KEY (`nota_2_id`),
  INDEX `indicador_id_idx` (`indicador_id` ASC) VISIBLE,
  CONSTRAINT `fk_nota_2_indicador`
    FOREIGN KEY (`indicador_id`)
    REFERENCES `mydb`.`indicadores` (`indicador_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`notas_3`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`notas_3` (
  `nota_3_id` INT NOT NULL AUTO_INCREMENT,
  `calificacion` DOUBLE NULL,
  `indicador_id` INT NOT NULL,
  PRIMARY KEY (`nota_3_id`),
  INDEX `indicador_id_idx` (`indicador_id` ASC) VISIBLE,
  CONSTRAINT `fk_nota_3_indicador`
    FOREIGN KEY (`indicador_id`)
    REFERENCES `mydb`.`indicadores` (`indicador_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Alumnos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Alumnos` (
  `alumno_id` INT NOT NULL AUTO_INCREMENT,
  `acudiente` VARCHAR(150) NOT NULL,
  `grado_id` INT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`alumno_id`),
  INDEX `grado_id_idx` (`grado_id` ASC) VISIBLE,
  INDEX `usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `fk_alumno_grado`
    FOREIGN KEY (`grado_id`)
    REFERENCES `mydb`.`Grados` (`grado_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_alumno_usuario`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`Usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Notas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Notas` (
  `notas_id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `nota_1_id` INT NOT NULL,
  `nota_2_id` INT NOT NULL,
  `nota_3_id` INT NOT NULL,
  PRIMARY KEY (`notas_id`),
  INDEX `alumno_id_idx` (`alumno_id` ASC) VISIBLE,
  INDEX `fk_Notas_notas_11_idx` (`nota_1_id` ASC) VISIBLE,
  INDEX `fk_Notas_notas_21_idx` (`nota_2_id` ASC) VISIBLE,
  INDEX `fk_Notas_notas_31_idx` (`nota_3_id` ASC) VISIBLE,
  CONSTRAINT `fk_nota_alumno`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`Alumnos` (`alumno_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_nota_1`
    FOREIGN KEY (`nota_1_id`)
    REFERENCES `mydb`.`notas_1` (`nota_1_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_nota_2`
    FOREIGN KEY (`nota_2_id`)
    REFERENCES `mydb`.`notas_2` (`nota_2_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nota_nota_3`
    FOREIGN KEY (`nota_3_id`)
    REFERENCES `mydb`.`notas_3` (`nota_3_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Faltas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Faltas` (
  `falta_id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `excusa` TINYINT NOT NULL,
  `user_materia_id` INT NOT NULL,
  PRIMARY KEY (`falta_id`),
  INDEX `alumno_id_idx` (`alumno_id` ASC) VISIBLE,
  INDEX `fk_Faltas_usuario_x_materia1_idx` (`user_materia_id` ASC) VISIBLE,
  CONSTRAINT `alumno_id`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`Alumnos` (`alumno_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_faltas_usuario_x_materia`
    FOREIGN KEY (`user_materia_id`)
    REFERENCES `mydb`.`usuario_x_materia` (`usuario_x_materia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Actas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Actas` (
  `acta_id` INT NOT NULL AUTO_INCREMENT,
  `alumno_id` INT NOT NULL,
  `fecha` DATE NOT NULL,
  `observacion` VARCHAR(150) NOT NULL,
  `compromisos` VARCHAR(150) NOT NULL,
  `usuario_x_materia_usuario_x_materia_id` INT NOT NULL,
  PRIMARY KEY (`acta_id`),
  INDEX `alumno_id_idx` (`alumno_id` ASC) VISIBLE,
  INDEX `fk_Actas_usuario_x_materia1_idx` (`usuario_x_materia_usuario_x_materia_id` ASC) VISIBLE,
  CONSTRAINT `fk_acta_alumno`
    FOREIGN KEY (`alumno_id`)
    REFERENCES `mydb`.`Alumnos` (`alumno_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_acta_usuario_x_materia`
    FOREIGN KEY (`usuario_x_materia_usuario_x_materia_id`)
    REFERENCES `mydb`.`usuario_x_materia` (`usuario_x_materia_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`telefonos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`telefonos` (
  `telefono_id` INT NOT NULL AUTO_INCREMENT,
  `contacto_id` INT NOT NULL,
  `numero` VARCHAR(45) NOT NULL,
  `tipo` VARCHAR(15) NOT NULL,
  PRIMARY KEY (`telefono_id`),
  INDEX `contacto_id_idx` (`contacto_id` ASC) VISIBLE,
  CONSTRAINT `fk_telefono_contacto`
    FOREIGN KEY (`contacto_id`)
    REFERENCES `mydb`.`contactos` (`contacto_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Auditorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Auditorias` (
  `auditoria_id` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `accion` VARCHAR(45) NOT NULL,
  `tabla` VARCHAR(45) NOT NULL,
  `anterior` JSON NOT NULL,
  `nuevo` JSON NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`auditoria_id`),
  INDEX `usuario_id_idx` (`usuario_id` ASC) VISIBLE,
  CONSTRAINT `usuario_id`
    FOREIGN KEY (`usuario_id`)
    REFERENCES `mydb`.`Usuarios` (`usuario_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;