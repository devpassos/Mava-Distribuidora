CREATE DATABASE  IF NOT EXISTS `mavachecklist` /*!40100 DEFAULT CHARACTER SET utf8 */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `mavachecklist`;
-- MySQL dump 10.13  Distrib 8.0.22, for Win64 (x86_64)
--
-- Host: localhost    Database: mavachecklist
-- ------------------------------------------------------
-- Server version	8.0.22

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `avaliacaorcaclicapa`
--

DROP TABLE IF EXISTS `avaliacaorcaclicapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacaorcaclicapa` (
  `idavaliacaocapa` int NOT NULL,
  `clientes_idcliente` int NOT NULL,
  `rca_idrca` int NOT NULL,
  `data` datetime DEFAULT NULL,
  `aprovado` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idavaliacaocapa`),
  KEY `fk_avaliacaorcaclicapa_clientes1_idx` (`clientes_idcliente`),
  KEY `fk_avaliacaorcaclicapa_rca1_idx` (`rca_idrca`),
  CONSTRAINT `fk_avaliacaorcaclicapa_clientes1` FOREIGN KEY (`clientes_idcliente`) REFERENCES `clientes` (`idcliente`),
  CONSTRAINT `fk_avaliacaorcaclicapa_rca1` FOREIGN KEY (`rca_idrca`) REFERENCES `rca` (`idrca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacaorcaclicapa`
--

LOCK TABLES `avaliacaorcaclicapa` WRITE;
/*!40000 ALTER TABLE `avaliacaorcaclicapa` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacaorcaclicapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacaorcacliitem`
--

DROP TABLE IF EXISTS `avaliacaorcacliitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacaorcacliitem` (
  `idavaliacao` int NOT NULL,
  `obs` varchar(245) DEFAULT NULL,
  `departamentos_iddepartamento` int NOT NULL,
  `itensavalicaocli_idavaliacaoitem` int NOT NULL,
  `avaliacaorcaclicapa_idavaliacaocapa` int NOT NULL,
  `resposta` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idavaliacao`),
  KEY `fk_avaliacaorcacli_departamentos1_idx` (`departamentos_iddepartamento`),
  KEY `fk_avaliacaorcacliitem_itensavalicaocli1_idx` (`itensavalicaocli_idavaliacaoitem`),
  KEY `fk_avaliacaorcacliitem_avaliacaorcaclicapa1_idx` (`avaliacaorcaclicapa_idavaliacaocapa`),
  CONSTRAINT `fk_avaliacaorcacli_departamentos1` FOREIGN KEY (`departamentos_iddepartamento`) REFERENCES `departamentos` (`iddepartamento`),
  CONSTRAINT `fk_avaliacaorcacliitem_avaliacaorcaclicapa1` FOREIGN KEY (`avaliacaorcaclicapa_idavaliacaocapa`) REFERENCES `avaliacaorcaclicapa` (`idavaliacaocapa`),
  CONSTRAINT `fk_avaliacaorcacliitem_itensavalicaocli1` FOREIGN KEY (`itensavalicaocli_idavaliacaoitem`) REFERENCES `itensavalicaocli` (`idavaliacaoitem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacaorcacliitem`
--

LOCK TABLES `avaliacaorcacliitem` WRITE;
/*!40000 ALTER TABLE `avaliacaorcacliitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacaorcacliitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacaosupervrcacapa`
--

DROP TABLE IF EXISTS `avaliacaosupervrcacapa`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacaosupervrcacapa` (
  `idavaliacao` int NOT NULL,
  `rca_idrca` int NOT NULL,
  `aprovado` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idavaliacao`),
  KEY `fk_avaliacaosupervrcacapa_rca1_idx` (`rca_idrca`),
  CONSTRAINT `fk_avaliacaosupervrcacapa_rca1` FOREIGN KEY (`rca_idrca`) REFERENCES `rca` (`idrca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacaosupervrcacapa`
--

LOCK TABLES `avaliacaosupervrcacapa` WRITE;
/*!40000 ALTER TABLE `avaliacaosupervrcacapa` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacaosupervrcacapa` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `avaliacaosupervrcaitem`
--

DROP TABLE IF EXISTS `avaliacaosupervrcaitem`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `avaliacaosupervrcaitem` (
  `idavaliacaoitem` int NOT NULL,
  `avaliacaosupervrcacapa_idavaliacao` int NOT NULL,
  `itensavaliacaorca_iditem` int NOT NULL,
  `resposta` varchar(1) DEFAULT NULL,
  PRIMARY KEY (`idavaliacaoitem`),
  KEY `fk_avaliacaosupervrcaitem_avaliacaosupervrcacapa1_idx` (`avaliacaosupervrcacapa_idavaliacao`),
  KEY `fk_avaliacaosupervrcaitem_itensavaliacaorca1_idx` (`itensavaliacaorca_iditem`),
  CONSTRAINT `fk_avaliacaosupervrcaitem_avaliacaosupervrcacapa1` FOREIGN KEY (`avaliacaosupervrcacapa_idavaliacao`) REFERENCES `avaliacaosupervrcacapa` (`idavaliacao`),
  CONSTRAINT `fk_avaliacaosupervrcaitem_itensavaliacaorca1` FOREIGN KEY (`itensavaliacaorca_iditem`) REFERENCES `itensavaliacaorca` (`iditem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `avaliacaosupervrcaitem`
--

LOCK TABLES `avaliacaosupervrcaitem` WRITE;
/*!40000 ALTER TABLE `avaliacaosupervrcaitem` DISABLE KEYS */;
/*!40000 ALTER TABLE `avaliacaosupervrcaitem` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `clientes`
--

DROP TABLE IF EXISTS `clientes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `clientes` (
  `idcliente` int NOT NULL,
  `rca_idrca` int NOT NULL,
  `diasemana` varchar(50) DEFAULT NULL,
  `sequencia` int DEFAULT NULL,
  `peridiocidade` int DEFAULT NULL,
  `dtproxvisita` datetime DEFAULT NULL,
  `codcliwint` int DEFAULT NULL,
  `razaosocial` varchar(100) DEFAULT NULL,
  `nomefantasia` varchar(100) DEFAULT NULL,
  `enderecocomercial` varchar(200) DEFAULT NULL,
  `bairro` varchar(45) DEFAULT NULL,
  `cidade` varchar(45) DEFAULT NULL,
  `telcomercial` varchar(45) DEFAULT NULL,
  `telcobranca` varchar(45) DEFAULT NULL,
  `atividade` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idcliente`),
  KEY `fk_clientes_rca1_idx` (`rca_idrca`),
  CONSTRAINT `fk_clientes_rca1` FOREIGN KEY (`rca_idrca`) REFERENCES `rca` (`idrca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `departamentos`
--

DROP TABLE IF EXISTS `departamentos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `departamentos` (
  `iddepartamento` int NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`iddepartamento`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `departamentos`
--

LOCK TABLES `departamentos` WRITE;
/*!40000 ALTER TABLE `departamentos` DISABLE KEYS */;
/*!40000 ALTER TABLE `departamentos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itensavaliacaorca`
--

DROP TABLE IF EXISTS `itensavaliacaorca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itensavaliacaorca` (
  `iditem` int NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  `peso` int DEFAULT NULL,
  PRIMARY KEY (`iditem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itensavaliacaorca`
--

LOCK TABLES `itensavaliacaorca` WRITE;
/*!40000 ALTER TABLE `itensavaliacaorca` DISABLE KEYS */;
/*!40000 ALTER TABLE `itensavaliacaorca` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `itensavalicaocli`
--

DROP TABLE IF EXISTS `itensavalicaocli`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `itensavalicaocli` (
  `idavaliacaoitem` int NOT NULL,
  `descricao` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idavaliacaoitem`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `itensavalicaocli`
--

LOCK TABLES `itensavalicaocli` WRITE;
/*!40000 ALTER TABLE `itensavalicaocli` DISABLE KEYS */;
/*!40000 ALTER TABLE `itensavalicaocli` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rca`
--

DROP TABLE IF EXISTS `rca`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rca` (
  `idrca` int NOT NULL,
  `nome` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`idrca`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rca`
--

LOCK TABLES `rca` WRITE;
/*!40000 ALTER TABLE `rca` DISABLE KEYS */;
INSERT INTO `rca` VALUES (1,'WELBER'),(2,'DAVID'),(3,'PABLO'),(10,'JULIANE'),(16,'mava');
/*!40000 ALTER TABLE `rca` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-15 17:33:45
