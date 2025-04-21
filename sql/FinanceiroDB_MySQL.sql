CREATE DATABASE `financeirodb`;

CREATE TABLE `niveisacesso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(150) NOT NULL,
  PRIMARY KEY (`id`)
);

CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `login` varchar(35) NOT NULL,
  `senha` varchar(150) NOT NULL,
  `idNivel` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FK_NiveisAcesso_idx` (`idNivel`),
  CONSTRAINT `FKUsuarios_NiveisAcesso` FOREIGN KEY (`idNivel`) REFERENCES `niveisacesso` (`id`)
);

CREATE TABLE `categoriasdespesa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCategoriasDespesa_Usuarios_idx` (`idUsuario`),
  CONSTRAINT `FKCategoriasDespesa_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
);

CREATE TABLE `lancamentosdespesa` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `datavencimento` date NOT NULL,
  `valorapagar` decimal(15,2) NOT NULL,
  `valorpago` decimal(15,2) DEFAULT NULL,
  `idCategoria` int NOT NULL,
  `idUsuario` int NOT NULL,
  `datapagamento` date DEFAULT NULL,
  `observacoes` varchar(255) DEFAULT NULL,
  `despesaFixa` tinyint NOT NULL DEFAULT '0',
  `nParc` int DEFAULT NULL,
  `totParc` int DEFAULT NULL,
  `arquivoAnexo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `FKLancamentosDespesa_Categorias_idx` (`idCategoria`),
  KEY `FKLancamentosDespesa_Usuarios_idx` (`idUsuario`),
  CONSTRAINT `FKLancamentosDespesa_Categorias` FOREIGN KEY (`idCategoria`) REFERENCES `categoriasdespesa` (`id`),
  CONSTRAINT `FKLancamentosDespesa_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
);

CREATE TABLE `categoriasreceita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `FKCategoriasReceita_Usuarios_idx` (`idUsuario`),
  CONSTRAINT `FKCategoriasReceita_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
);

CREATE TABLE `lancamentosreceita` (
  `id` int NOT NULL AUTO_INCREMENT,
  `descricao` varchar(255) NOT NULL,
  `dataareceber` date NOT NULL,
  `valorareceber` decimal(15,2) NOT NULL,
  `datarecebimento` date DEFAULT NULL,
  `valorrecebido` decimal(15,2) DEFAULT NULL,
  `idCategoria` int NOT NULL,
  `idUsuario` int NOT NULL,
  `observacoes` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`,`idCategoria`),
  KEY `FKLancamentosReceita_Categorias_idx` (`idCategoria`),
  KEY `FKLancamentosReceita_Usuarios_idx` (`idUsuario`),
  CONSTRAINT `FKLancamentosReceita_Categorias` FOREIGN KEY (`idCategoria`) REFERENCES `categoriasreceita` (`id`),
  CONSTRAINT `FKLancamentosReceita_Usuarios` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`id`)
);
