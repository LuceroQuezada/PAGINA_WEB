-- MySQL dump 10.13  Distrib 8.0.42, for Win64 (x86_64)
--
-- Host: localhost    Database: academia_grupoa1
-- ------------------------------------------------------
-- Server version	8.0.42

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
-- Table structure for table `asistencia`
--

DROP TABLE IF EXISTS `asistencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `asistencia` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_seccion` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `fecha` date NOT NULL,
  `presente` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_asistencia` (`id_seccion`,`id_estudiante`,`fecha`),
  KEY `id_estudiante` (`id_estudiante`),
  CONSTRAINT `asistencia_ibfk_1` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id`) ON DELETE CASCADE,
  CONSTRAINT `asistencia_ibfk_2` FOREIGN KEY (`id_estudiante`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `asistencia`
--

LOCK TABLES `asistencia` WRITE;
/*!40000 ALTER TABLE `asistencia` DISABLE KEYS */;
INSERT INTO `asistencia` VALUES (1,1,12,'2025-07-22',1),(2,3,12,'2025-07-22',0),(3,3,13,'2025-07-22',1),(4,2,12,'2025-11-03',1),(5,2,13,'2025-11-03',0);
/*!40000 ALTER TABLE `asistencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso`
--

DROP TABLE IF EXISTS `curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(150) NOT NULL,
  `carrera` enum('Ingenieria','Medicina','Derecho') NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso`
--

LOCK TABLES `curso` WRITE;
/*!40000 ALTER TABLE `curso` DISABLE KEYS */;
INSERT INTO `curso` VALUES (1,'Fundamentos de Cálculo','Ingenieria'),(2,'Física General','Ingenieria'),(3,'Álgebra y Geometría Analítica','Ingenieria'),(4,'Introducción a la Programación','Ingenieria'),(5,'Química para Ingeniería','Ingenieria'),(6,'Biología Celular y Molecular','Medicina'),(7,'Química Orgánica','Medicina'),(8,'Anatomía y Fisiología Humana','Medicina'),(9,'Bioquímica Médica','Medicina'),(10,'Introducción a la Microbiología','Medicina'),(11,'Introducción al Derecho y Teoría Jurídica','Derecho'),(12,'Derecho Constitucional','Derecho'),(13,'Metodología de la Investigación Jurídica','Derecho'),(14,'Derecho Civil I','Derecho'),(15,'Redacción y Argumentación Jurídica','Derecho');
/*!40000 ALTER TABLE `curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `curso_docente`
--

DROP TABLE IF EXISTS `curso_docente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `curso_docente` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_curso` int NOT NULL,
  `id_docente` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_curso` (`id_curso`),
  KEY `id_docente` (`id_docente`),
  CONSTRAINT `curso_docente_ibfk_1` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE,
  CONSTRAINT `curso_docente_ibfk_2` FOREIGN KEY (`id_docente`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `curso_docente`
--

LOCK TABLES `curso_docente` WRITE;
/*!40000 ALTER TABLE `curso_docente` DISABLE KEYS */;
INSERT INTO `curso_docente` VALUES (1,3,2),(2,5,2),(3,2,2);
/*!40000 ALTER TABLE `curso_docente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo`
--

DROP TABLE IF EXISTS `grupo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `carrera` enum('Ingenieria','Medicina','Derecho') NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo`
--

LOCK TABLES `grupo` WRITE;
/*!40000 ALTER TABLE `grupo` DISABLE KEYS */;
INSERT INTO `grupo` VALUES (1,'I1','Ingenieria','2025-07-22 19:29:14'),(2,'I2','Ingenieria','2025-07-22 19:29:14'),(3,'M1','Medicina','2025-07-22 19:29:14'),(4,'M2','Medicina','2025-07-22 19:29:14'),(5,'D1','Derecho','2025-07-22 19:29:14'),(6,'D2','Derecho','2025-07-22 19:29:14'),(7,'I1','Ingenieria','2025-07-22 19:34:44'),(8,'I2','Ingenieria','2025-07-22 19:34:44'),(9,'M1','Medicina','2025-07-22 19:34:44'),(10,'M2','Medicina','2025-07-22 19:34:44'),(11,'D1','Derecho','2025-07-22 19:34:44'),(12,'D2','Derecho','2025-07-22 19:34:44');
/*!40000 ALTER TABLE `grupo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupo_estudiante`
--

DROP TABLE IF EXISTS `grupo_estudiante`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupo_estudiante` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_grupo` int NOT NULL,
  `id_usuario` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_grupo` (`id_grupo`),
  KEY `id_usuario` (`id_usuario`),
  CONSTRAINT `grupo_estudiante_ibfk_1` FOREIGN KEY (`id_grupo`) REFERENCES `grupo` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grupo_estudiante_ibfk_2` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupo_estudiante`
--

LOCK TABLES `grupo_estudiante` WRITE;
/*!40000 ALTER TABLE `grupo_estudiante` DISABLE KEYS */;
INSERT INTO `grupo_estudiante` VALUES (1,1,12),(2,1,13);
/*!40000 ALTER TABLE `grupo_estudiante` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `grupos`
--

DROP TABLE IF EXISTS `grupos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `grupos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(50) NOT NULL,
  `carrera` enum('Ingenieria','Medicina','Derecho') NOT NULL,
  `numero_grupo` int NOT NULL,
  `fecha_creacion` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `grupos`
--

LOCK TABLES `grupos` WRITE;
/*!40000 ALTER TABLE `grupos` DISABLE KEYS */;
INSERT INTO `grupos` VALUES (1,'I1','Ingenieria',1,'2025-07-19 14:46:47'),(2,'I1','Ingenieria',1,'2025-07-19 14:59:47'),(3,'I1','Ingenieria',1,'2025-07-19 15:01:11'),(4,'I2','Ingenieria',2,'2025-07-19 15:01:11');
/*!40000 ALTER TABLE `grupos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `horario`
--

DROP TABLE IF EXISTS `horario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `horario` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_curso_docente` int NOT NULL,
  `dia` enum('Lunes','Martes','Miercoles','Jueves','Viernes') NOT NULL,
  `hora_inicio` time NOT NULL,
  `hora_fin` time NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_curso_docente` (`id_curso_docente`),
  CONSTRAINT `horario_ibfk_1` FOREIGN KEY (`id_curso_docente`) REFERENCES `curso_docente` (`id`) ON DELETE CASCADE,
  CONSTRAINT `horario_chk_1` CHECK (((`hora_inicio` >= '09:00:00') and (`hora_fin` <= '13:30:00'))),
  CONSTRAINT `horario_chk_2` CHECK (((time_to_sec(`hora_fin`) - time_to_sec(`hora_inicio`)) = 5400))
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `horario`
--

LOCK TABLES `horario` WRITE;
/*!40000 ALTER TABLE `horario` DISABLE KEYS */;
INSERT INTO `horario` VALUES (1,1,'Lunes','10:00:00','11:30:00'),(2,2,'Martes','10:00:00','11:30:00'),(3,3,'Miercoles','10:00:00','11:30:00');
/*!40000 ALTER TABLE `horario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `material_curso`
--

DROP TABLE IF EXISTS `material_curso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `material_curso` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_usuario` int NOT NULL,
  `id_curso` int DEFAULT NULL,
  `id_seccion` int DEFAULT NULL,
  `titulo` varchar(200) NOT NULL,
  `descripcion` text,
  `archivo` varchar(255) NOT NULL,
  `tipo` enum('PDF','DOC','IMG','VIDEO','ZIP') NOT NULL,
  `fecha_subida` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `id_usuario` (`id_usuario`),
  KEY `id_seccion` (`id_seccion`),
  KEY `id_curso` (`id_curso`),
  CONSTRAINT `material_curso_ibfk_1` FOREIGN KEY (`id_usuario`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE,
  CONSTRAINT `material_curso_ibfk_2` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id`) ON DELETE CASCADE,
  CONSTRAINT `material_curso_ibfk_3` FOREIGN KEY (`id_curso`) REFERENCES `curso` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `material_curso`
--

LOCK TABLES `material_curso` WRITE;
/*!40000 ALTER TABLE `material_curso` DISABLE KEYS */;
INSERT INTO `material_curso` VALUES (1,1,3,NULL,'Semana 1','Semanita 1','18002892-fcef-4201-9248-89e6cfced945_Semana_09_-_Tema_04__Tarea_-_Avance_de_Proyecto_Final_1_-_GRUPO.pdf','PDF','2025-07-22 19:56:39'),(2,1,3,NULL,'Semana 2','Semanita 2','6137a330-889e-4e41-ac9b-6a2d4de5d78e_Pregunta4.docx','DOC','2025-07-23 00:46:32'),(3,1,2,NULL,'Semana 4','Semanita 4','475d6936-3259-48f3-8979-c6cd153b0e69_Pregunta4__1_.docx','DOC','2025-07-23 02:15:19');
/*!40000 ALTER TABLE `material_curso` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `nota`
--

DROP TABLE IF EXISTS `nota`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `nota` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_seccion` int NOT NULL,
  `id_estudiante` int NOT NULL,
  `nota1` decimal(5,2) NOT NULL,
  `nota2` decimal(5,2) NOT NULL,
  `nota3` decimal(5,2) NOT NULL,
  `nota_final` decimal(5,2) NOT NULL,
  `promedio` decimal(5,2) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `uk_nota` (`id_seccion`,`id_estudiante`),
  KEY `id_estudiante` (`id_estudiante`),
  CONSTRAINT `nota_ibfk_1` FOREIGN KEY (`id_seccion`) REFERENCES `seccion` (`id`) ON DELETE CASCADE,
  CONSTRAINT `nota_ibfk_2` FOREIGN KEY (`id_estudiante`) REFERENCES `usuarios` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `nota`
--

LOCK TABLES `nota` WRITE;
/*!40000 ALTER TABLE `nota` DISABLE KEYS */;
INSERT INTO `nota` VALUES (1,1,12,18.00,18.00,18.00,0.00,13.50),(2,3,12,0.00,0.00,0.00,0.00,0.00),(3,3,13,18.00,0.00,0.00,0.00,4.50),(4,1,13,0.00,0.00,0.00,0.00,0.00);
/*!40000 ALTER TABLE `nota` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `preinscripcion`
--

DROP TABLE IF EXISTS `preinscripcion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `preinscripcion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) NOT NULL,
  `apellido` varchar(100) NOT NULL,
  `dni` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `direccion` varchar(200) DEFAULT NULL,
  `colegio` varchar(150) DEFAULT NULL,
  `carrera` enum('Ingenieria','Medicina','Derecho') NOT NULL,
  `estado` enum('pendiente','aceptado','rechazado','cancelado') NOT NULL DEFAULT 'pendiente',
  `intentos` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `dni` (`dni`),
  UNIQUE KEY `email` (`email`),
  UNIQUE KEY `unq_nombre_apellido` (`nombre`,`apellido`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `preinscripcion`
--

LOCK TABLES `preinscripcion` WRITE;
/*!40000 ALTER TABLE `preinscripcion` DISABLE KEYS */;
INSERT INTO `preinscripcion` VALUES (1,'Alejandra','Chorres','73737750','alejandra@gmail.com','Calle Cajamarca 546','Parcemon','Ingenieria','aceptado',0),(2,'Alexa','Herrera','73737751','alexa@gmail.com','Calle Cajamarca 546','Parcemon','Medicina','pendiente',0),(3,'Alessia','Quezada','73737752','alessia@gmail.com','Calle Cajamarca 546','Parcemon','Ingenieria','pendiente',0),(4,'Angela','Socola','73737741','angela@gmail.com','Calle Cajamarca 546','Parcemon','Ingenieria','rechazado',0),(5,'Milton','Suarez','12345678','suarezvitealdair@gmail.com','Calle Cajamarca 546','Parcemon','Ingenieria','aceptado',0);
/*!40000 ALTER TABLE `preinscripcion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rol`
--

DROP TABLE IF EXISTS `rol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rol` (
  `id` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(20) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rol`
--

LOCK TABLES `rol` WRITE;
/*!40000 ALTER TABLE `rol` DISABLE KEYS */;
INSERT INTO `rol` VALUES (1,'administrador'),(2,'docente'),(3,'estudiante');
/*!40000 ALTER TABLE `rol` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `seccion`
--

DROP TABLE IF EXISTS `seccion`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `seccion` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_horario` int NOT NULL,
  `nombre` enum('A','B') NOT NULL,
  `id_grupo` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_horario` (`id_horario`),
  KEY `id_grupo` (`id_grupo`),
  CONSTRAINT `seccion_ibfk_1` FOREIGN KEY (`id_horario`) REFERENCES `horario` (`id`) ON DELETE CASCADE,
  CONSTRAINT `seccion_ibfk_2` FOREIGN KEY (`id_grupo`) REFERENCES `grupo` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `seccion`
--

LOCK TABLES `seccion` WRITE;
/*!40000 ALTER TABLE `seccion` DISABLE KEYS */;
INSERT INTO `seccion` VALUES (1,1,'A',1),(2,2,'A',1),(3,3,'A',1);
/*!40000 ALTER TABLE `seccion` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `telefono`
--

DROP TABLE IF EXISTS `telefono`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telefono` (
  `id` int NOT NULL AUTO_INCREMENT,
  `id_preinscripcion` int NOT NULL,
  `numero` varchar(15) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `id_preinscripcion` (`id_preinscripcion`),
  CONSTRAINT `telefono_ibfk_1` FOREIGN KEY (`id_preinscripcion`) REFERENCES `preinscripcion` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `telefono`
--

LOCK TABLES `telefono` WRITE;
/*!40000 ALTER TABLE `telefono` DISABLE KEYS */;
INSERT INTO `telefono` VALUES (1,1,'955838396'),(2,2,'955838396'),(3,3,'955838396'),(4,4,'955838396'),(5,5,'955838396');
/*!40000 ALTER TABLE `telefono` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `id` int NOT NULL AUTO_INCREMENT,
  `correo` varchar(50) NOT NULL,
  `password` varchar(100) NOT NULL,
  `nombre` varchar(50) NOT NULL,
  `apellido` varchar(50) NOT NULL,
  `carrera` enum('Ingenieria','Medicina','Derecho') DEFAULT NULL,
  `grupo` varchar(5) DEFAULT NULL,
  `id_rol` int NOT NULL,
  `estado` tinyint DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `correo` (`correo`),
  KEY `id_rol` (`id_rol`),
  CONSTRAINT `usuarios_ibfk_1` FOREIGN KEY (`id_rol`) REFERENCES `rol` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'a1@academiaA1.com','admin123','Admin','General',NULL,NULL,1,1),(2,'c1001@academiaA1.com','docente123','Juan','Pérez',NULL,NULL,2,1),(4,'a2@academiaA1.com','admin123','Ronaldo','Vasquez',NULL,NULL,1,1),(5,'a3@academiaA1.com','admin123','Roger','Castro',NULL,NULL,1,1),(6,'c1002@academiaA1.com','docente123','Oswaldo','Chorres',NULL,NULL,2,1),(7,'c1003@academiaA1.com','docente123','Mary','Herrera',NULL,NULL,2,1),(8,'c1004@academiaA1.com','docente123','Elber','Socola',NULL,NULL,2,1),(9,'c1005@academiaA1.com','docente123','Javier','Socola',NULL,NULL,2,1),(10,'c1006@academiaA1.com','docente123','Aldo','Castro',NULL,NULL,2,1),(11,'u73737750@academiaA1.com','C5kct1Pd','Alejandra','Chorres','Ingenieria',NULL,3,1),(12,'u22212954@academiaA1.com','estudiante123','Ana','Gómez','Ingenieria',NULL,3,1),(13,'u12345678@academiaA1.com','nR7Sh8QH','Milton','Suarez','Ingenieria',NULL,3,1);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-06  0:17:26
