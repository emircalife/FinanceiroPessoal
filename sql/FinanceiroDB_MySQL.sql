CREATE DATABASE `financeirodb`

CREATE TABLE `financeirodb`.`niveisacesso` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(150) NOT NULL,
  PRIMARY KEY (`id`));
  
 CREATE TABLE `financeirodb`.`usuarios` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(35) NOT NULL,
  `senha` VARCHAR(150) NOT NULL,
  `idNivel` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FK_NiveisAcesso_idx` (`idNivel` ASC) VISIBLE,
  CONSTRAINT `FKUsuarios_NiveisAcesso`
    FOREIGN KEY (`idNivel`)
    REFERENCES `financeirodb`.`niveisacesso` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `financeirodb`.`categoriasdespesa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKCategoriasDespesa_Usuarios_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `FKCategoriasDespesa_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `financeirodb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `financeirodb`.`categoriasreceita` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `FKCategoriasReceita_Usuarios_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `FKCategoriasReceita_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `financeirodb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
	
CREATE TABLE `financeirodb`.`lancamentosdespesa` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `datavencimento` DATE NOT NULL,
  `valorapagar` DECIMAL(15,2) NOT NULL,
  `valorpago` DECIMAL(15,2) NULL,
  `idCategoria` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  `datapagamento` DATE NULL,
  PRIMARY KEY (`id`),
  INDEX `FKLancamentosDespesa_Categorias_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `FKLancamentosDespesa_Usuarios_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `FKLancamentosDespesa_Categorias`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `financeirodb`.`categoriasdespesa` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLancamentosDespesa_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `financeirodb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);

CREATE TABLE `financeirodb`.`lancamentosreceita` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(255) NOT NULL,
  `dataareceber` DATE NOT NULL,
  `valorareceber` DECIMAL(15,2) NOT NULL,
  `datarecebimento` DATE NULL,
  `LancamentosReceitacol` VARCHAR(45) NULL,
  `valorrecebido` DECIMAL(15,2) NULL,
  `idCategoria` INT NOT NULL,
  `idUsuario` INT NOT NULL,
  PRIMARY KEY (`id`, `idCategoria`),
  INDEX `FKLancamentosReceita_Categorias_idx` (`idCategoria` ASC) VISIBLE,
  INDEX `FKLancamentosReceita_Usuarios_idx` (`idUsuario` ASC) VISIBLE,
  CONSTRAINT `FKLancamentosReceita_Categorias`
    FOREIGN KEY (`idCategoria`)
    REFERENCES `financeirodb`.`categoriasreceita` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FKLancamentosReceita_Usuarios`
    FOREIGN KEY (`idUsuario`)
    REFERENCES `financeirodb`.`usuarios` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION);
