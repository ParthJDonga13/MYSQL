-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema myhospitaldb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema myhospitaldb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `myhospitaldb` DEFAULT CHARACTER SET utf8 ;
USE `myhospitaldb` ;

-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_departments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_departments` (
  `department_id` INT NOT NULL AUTO_INCREMENT,
  `department_name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_doctors`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_doctors` (
  `doctor_id` INT NOT NULL AUTO_INCREMENT,
  `doctor_name` VARCHAR(45) NOT NULL,
  `doctor_contactno` VARCHAR(13) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`doctor_id`),
  INDEX `fk_doctor_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_doctor_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `myhospitaldb`.`mst_departments` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_rooms`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_rooms` (
  `room_id` INT NOT NULL AUTO_INCREMENT,
  `room_type` VARCHAR(45) NOT NULL,
  `room_floor` INT NOT NULL,
  `isAvailable` BIT(1) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `fk_room_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `myhospitaldb`.`mst_departments` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_patients`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_patients` (
  `patient_id` INT NOT NULL AUTO_INCREMENT,
  `patient_firstname` VARCHAR(45) NOT NULL,
  `patient_lastname` VARCHAR(45) NOT NULL,
  `patient_contactno` VARCHAR(13) NOT NULL,
  `patient_address` VARCHAR(3670) NOT NULL,
  `patient_gender` VARCHAR(15) NOT NULL,
  `room_id` INT NOT NULL,
  PRIMARY KEY (`patient_id`),
  INDEX `fk_patient_room_idx` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_patient_room`
    FOREIGN KEY (`room_id`)
    REFERENCES `myhospitaldb`.`mst_rooms` (`room_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_appoitments`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_appoitments` (
  `appointment_id` INT NOT NULL AUTO_INCREMENT,
  `dateofadmission` DATETIME NOT NULL,
  `dateofdischarge` DATETIME NULL DEFAULT NULL,
  `doctor_id` INT NOT NULL,
  `patient_id` INT NOT NULL,
  PRIMARY KEY (`appointment_id`),
  INDEX `fk_appointment_doctor_idx` (`doctor_id` ASC) VISIBLE,
  INDEX `fk_appointment_patient_idx` (`patient_id` ASC) VISIBLE,
  CONSTRAINT `fk_appointment_doctor`
    FOREIGN KEY (`doctor_id`)
    REFERENCES `myhospitaldb`.`mst_doctors` (`doctor_id`),
  CONSTRAINT `fk_appointment_patient`
    FOREIGN KEY (`patient_id`)
    REFERENCES `myhospitaldb`.`mst_patients` (`patient_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_nurses`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_nurses` (
  `nurse_id` INT NOT NULL AUTO_INCREMENT,
  `nurse_name` VARCHAR(45) NOT NULL,
  `nurse_contactno` VARCHAR(13) NOT NULL,
  `department_id` INT NOT NULL,
  PRIMARY KEY (`nurse_id`),
  INDEX `fk_nurse_department_idx` (`department_id` ASC) VISIBLE,
  CONSTRAINT `fk_nurse_department`
    FOREIGN KEY (`department_id`)
    REFERENCES `myhospitaldb`.`mst_departments` (`department_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


-- -----------------------------------------------------
-- Table `myhospitaldb`.`mst_nurseroom`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `myhospitaldb`.`mst_nurseroom` (
  `nurseroom_id` INT NOT NULL AUTO_INCREMENT,
  `nurse_id` INT NOT NULL,
  `room_id` INT NOT NULL,
  `AssignOn` DATETIME NOT NULL,
  PRIMARY KEY (`nurseroom_id`, `nurse_id`, `room_id`),
  INDEX `fk_nurseroom_nurses` (`nurse_id` ASC) VISIBLE,
  INDEX `fk_nurseroom_room` (`room_id` ASC) VISIBLE,
  CONSTRAINT `fk_nurseroom_nurse`
    FOREIGN KEY (`nurse_id`)
    REFERENCES `myhospitaldb`.`mst_nurses` (`nurse_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_nurseroom_room`
    FOREIGN KEY (`room_id`)
    REFERENCES `myhospitaldb`.`mst_rooms` (`room_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb3;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
