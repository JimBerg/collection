SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL';

CREATE SCHEMA IF NOT EXISTS `LunchApp` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `LunchApp` ;

-- -----------------------------------------------------
-- Table `LunchApp`.`user`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`user` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `firstname` VARCHAR(45) NULL ,
  `lastname` VARCHAR(45) NULL ,
  `email` VARCHAR(120) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`menu_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`menu_category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`courier_category`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`courier_category` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `name` VARCHAR(120) NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`courier`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`courier` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `courier_category_id` INT NOT NULL ,
  `name` VARCHAR(120) NULL ,
  `adress` VARCHAR(120) NULL ,
  `phone` VARCHAR(120) NULL ,
  `email` VARCHAR(120) NULL ,
  `url` VARCHAR(120) NULL ,
  `delivery_conditions` TEXT NULL ,
  PRIMARY KEY (`id`, `courier_category_id`) ,
  INDEX `fk_courier_courier_category` (`courier_category_id` ASC) ,
  CONSTRAINT `fk_courier_courier_category`
    FOREIGN KEY (`courier_category_id` )
    REFERENCES `LunchApp`.`courier_category` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`menu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`menu` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `courier_id` INT NOT NULL ,
  `menu_category_id` INT NOT NULL ,
  `name` VARCHAR(120) NULL ,
  `price` DOUBLE NULL ,
  PRIMARY KEY (`id`, `courier_id`, `menu_category_id`) ,
  INDEX `fk_menu_menu_category1` (`menu_category_id` ASC) ,
  INDEX `fk_menu_courier1` (`courier_id` ASC) ,
  CONSTRAINT `fk_menu_menu_category1`
    FOREIGN KEY (`menu_category_id` )
    REFERENCES `LunchApp`.`menu_category` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_menu_courier1`
    FOREIGN KEY (`courier_id` )
    REFERENCES `LunchApp`.`courier` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`order`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`order` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `user_id` INT NOT NULL ,
  `menu_id` INT NOT NULL ,
  `date` VARCHAR(45) NULL ,
  `confirmed` TINYINT(1) NOT NULL DEFAULT false ,
  `payed` TINYINT(1) NOT NULL DEFAULT false ,
  PRIMARY KEY (`id`, `user_id`, `menu_id`) ,
  INDEX `fk_order_user1` (`user_id` ASC) ,
  INDEX `fk_order_menu1` (`menu_id` ASC) ,
  CONSTRAINT `fk_order_user1`
    FOREIGN KEY (`user_id` )
    REFERENCES `LunchApp`.`user` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_order_menu1`
    FOREIGN KEY (`menu_id` )
    REFERENCES `LunchApp`.`menu` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`availability`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`availability` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `weekday` VARCHAR(45) NULL ,
  `special_conditions` TEXT NULL ,
  PRIMARY KEY (`id`) )
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`availability_to_menu`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`availability_to_menu` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `availability_id` INT NOT NULL ,
  `menu_id` INT NOT NULL ,
  PRIMARY KEY (`id`, `availability_id`, `menu_id`) ,
  INDEX `fk_availability_to_menu_availability1` (`availability_id` ASC) ,
  INDEX `fk_availability_to_menu_menu1` (`menu_id` ASC) ,
  CONSTRAINT `fk_availability_to_menu_availability1`
    FOREIGN KEY (`availability_id` )
    REFERENCES `LunchApp`.`availability` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_availability_to_menu_menu1`
    FOREIGN KEY (`menu_id` )
    REFERENCES `LunchApp`.`menu` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `LunchApp`.`courier_history`
-- -----------------------------------------------------
CREATE  TABLE IF NOT EXISTS `LunchApp`.`courier_history` (
  `id` INT NOT NULL AUTO_INCREMENT ,
  `courier_id` INT NOT NULL ,
  `date` VARCHAR(45) NULL ,
  PRIMARY KEY (`id`, `courier_id`) ,
  INDEX `fk_courier_history_courier1` (`courier_id` ASC) ,
  CONSTRAINT `fk_courier_history_courier1`
    FOREIGN KEY (`courier_id` )
    REFERENCES `LunchApp`.`courier` (`id` )
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;



SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
