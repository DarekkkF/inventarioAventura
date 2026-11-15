-- MySQL dump 10.13  Distrib 26.7.0, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: inventario_aventura
-- ------------------------------------------------------
-- Server version	26.7.0

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `inventario_aventura`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `inventario_aventura` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `inventario_aventura`;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=37 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',3,'add_permission'),(6,'Can change permission',3,'change_permission'),(7,'Can delete permission',3,'delete_permission'),(8,'Can view permission',3,'view_permission'),(9,'Can add group',2,'add_group'),(10,'Can change group',2,'change_group'),(11,'Can delete group',2,'delete_group'),(12,'Can view group',2,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add user',6,'add_usuario'),(22,'Can change user',6,'change_usuario'),(23,'Can delete user',6,'delete_usuario'),(24,'Can view user',6,'view_usuario'),(25,'Can add categoria',7,'add_categoria'),(26,'Can change categoria',7,'change_categoria'),(27,'Can delete categoria',7,'delete_categoria'),(28,'Can view categoria',7,'view_categoria'),(29,'Can add experiencia',8,'add_experiencia'),(30,'Can change experiencia',8,'change_experiencia'),(31,'Can delete experiencia',8,'delete_experiencia'),(32,'Can view experiencia',8,'view_experiencia'),(33,'Can add reserva',9,'add_reserva'),(34,'Can change reserva',9,'change_reserva'),(35,'Can delete reserva',9,'delete_reserva'),(36,'Can view reserva',9,'view_reserva');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_usuario`
--

DROP TABLE IF EXISTS `cuentas_usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_usuario` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(254) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `rol` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_usuario`
--

LOCK TABLES `cuentas_usuario` WRITE;
/*!40000 ALTER TABLE `cuentas_usuario` DISABLE KEYS */;
INSERT INTO `cuentas_usuario` VALUES (1,'pbkdf2_sha256$1500000$80Bj5wpLbXbnIqLiwS4uT5$LAH2M6c7HQ0jcnZRQxk+fYq4X+4wrRMbZmSrAAzrkto=','2026-11-15 16:40:49.714182',0,'admin','Administración','','admin_demo@example.com',0,1,'2026-11-15 16:33:20.878087','admin'),(2,'pbkdf2_sha256$1500000$yda8X0j4S3UTA7WL5OFh2U$8GDXykOs3SYGBI4bFvfEkIU4fIyIg9d/2vEydafZIPs=','2026-11-15 16:45:36.359596',0,'guia_1','Camila','','guia_1@example.com',0,1,'2026-11-15 16:33:21.134790','guia'),(3,'pbkdf2_sha256$1500000$tKKsbgXn8R2Lcdd1AO2kj9$hLomx7yYG3rNJkqUWOakagyzLx3w6iBjirj8c/5pQdA=','2026-11-15 16:47:26.977996',0,'guia_2','Tomás','','guia_2@example.com',0,1,'2026-11-15 16:33:21.400156','guia'),(4,'pbkdf2_sha256$1500000$Q4wA2epE5BW7ymxizP8hBD$tUmr0JctmgHXeDp8MDDGmW4yuxu1bddXjX8un4Cy7LU=','2026-11-15 16:47:56.595997',0,'turista_1','Valentina','','turista_1@example.com',0,1,'2026-11-15 16:33:21.646013','turista'),(5,'pbkdf2_sha256$1500000$QshGhc5PraUGztLrwwx14F$1rhtjcZUMeuvqTtEWWyWRNUBjaUpMK+wdl6HvGBS7bQ=',NULL,0,'turista_2','Diego','','turista_2@example.com',0,1,'2026-11-15 16:33:21.898926','turista'),(6,'pbkdf2_sha256$1500000$V5ma2Ocz7Lrewj6WmrFk7Q$aZYQjrxZ6Uu+EM8ENu6XHXbKNXTrc1mtUHlmSZDcJ5w=','2026-11-15 16:39:27.405716',0,'Darekk','Darek','Fuentes','darek@gmail.com',0,1,'2026-11-15 16:39:20.700874','turista');
/*!40000 ALTER TABLE `cuentas_usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_usuario_groups`
--

DROP TABLE IF EXISTS `cuentas_usuario_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_usuario_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cuentas_usuario_groups_usuario_id_group_id_f5ef6c73_uniq` (`usuario_id`,`group_id`),
  KEY `cuentas_usuario_groups_group_id_e6725cc8_fk_auth_group_id` (`group_id`),
  CONSTRAINT `cuentas_usuario_groups_group_id_e6725cc8_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `cuentas_usuario_groups_usuario_id_251ff583_fk_cuentas_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_usuario_groups`
--

LOCK TABLES `cuentas_usuario_groups` WRITE;
/*!40000 ALTER TABLE `cuentas_usuario_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentas_usuario_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cuentas_usuario_user_permissions`
--

DROP TABLE IF EXISTS `cuentas_usuario_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cuentas_usuario_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `usuario_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `cuentas_usuario_user_per_usuario_id_permission_id_26c0acea_uniq` (`usuario_id`,`permission_id`),
  KEY `cuentas_usuario_user_permission_id_1753ad79_fk_auth_perm` (`permission_id`),
  CONSTRAINT `cuentas_usuario_user_permission_id_1753ad79_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `cuentas_usuario_user_usuario_id_5a9718f1_fk_cuentas_u` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cuentas_usuario_user_permissions`
--

LOCK TABLES `cuentas_usuario_user_permissions` WRITE;
/*!40000 ALTER TABLE `cuentas_usuario_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `cuentas_usuario_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext COLLATE utf8mb4_unicode_ci,
  `object_repr` varchar(200) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_cuentas_usuario_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_cuentas_usuario_id` FOREIGN KEY (`user_id`) REFERENCES `cuentas_usuario` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `model` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(2,'auth','group'),(3,'auth','permission'),(4,'contenttypes','contenttype'),(6,'cuentas','usuario'),(7,'experiencias','categoria'),(8,'experiencias','experiencia'),(9,'experiencias','reserva'),(5,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2026-11-15 16:33:18.628354'),(2,'contenttypes','0002_remove_content_type_name','2026-11-15 16:33:18.728953'),(3,'auth','0001_initial','2026-11-15 16:33:19.001051'),(4,'auth','0002_alter_permission_name_max_length','2026-11-15 16:33:19.068087'),(5,'auth','0003_alter_user_email_max_length','2026-11-15 16:33:19.073143'),(6,'auth','0004_alter_user_username_opts','2026-11-15 16:33:19.077844'),(7,'auth','0005_alter_user_last_login_null','2026-11-15 16:33:19.082565'),(8,'auth','0006_require_contenttypes_0002','2026-11-15 16:33:19.085343'),(9,'auth','0007_alter_validators_add_error_messages','2026-11-15 16:33:19.090397'),(10,'auth','0008_alter_user_username_max_length','2026-11-15 16:33:19.094875'),(11,'auth','0009_alter_user_last_name_max_length','2026-11-15 16:33:19.099892'),(12,'auth','0010_alter_group_name_max_length','2026-11-15 16:33:19.114219'),(13,'auth','0011_update_proxy_permissions','2026-11-15 16:33:19.121482'),(14,'auth','0012_alter_user_first_name_max_length','2026-11-15 16:33:19.126839'),(15,'cuentas','0001_initial','2026-11-15 16:33:19.443646'),(16,'admin','0001_initial','2026-11-15 16:33:19.578806'),(17,'admin','0002_logentry_remove_auto_add','2026-11-15 16:33:19.584645'),(18,'admin','0003_logentry_add_action_flag_choices','2026-11-15 16:33:19.590642'),(19,'experiencias','0001_initial','2026-11-15 16:33:19.883851'),(20,'sessions','0001_initial','2026-11-15 16:33:19.914442');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `session_data` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2hry9d48mi620j3oip9o8ci2q10akgum','.eJxVjDEOwjAMAP_iGUXEpE3SkZ03RI7t0AJqpKadEH9HlTrAene6NyTa1jFtTZc0CQyAcPplmfip8y7kQfO9Gq7zukzZ7Ik5bDO3Kvq6Hu3fYKQ2wgA2dsKO0fee1FvpLqQaFTEzhtAHT_nMlnriaGOm4CKWUkIRx5Y7Rvh8AfIuOJw:1xSdAp:SOLIGKbWzWr8SI9ob0NssF3ivlRQEkAfjtqkkpZSbus','2026-11-29 16:33:47.989417'),('917dk7kxbtbrbv00bwcyi7lntkolyk0y','.eJxVjMsOwiAQAP9lz4bwWoEevfcbmoUFqRpI-jgZ_9006UGvM5N5w0T7Vqd9zcs0Mwyg4PLLIqVnbofgB7V7F6m3bZmjOBJx2lWMnfPrdrZ_g0prhQFSsFd00UiWRWdrPBWjiyGtpEZnrUwWA2dSKTrFKWunpcGIBgN7VB4-X8pfNwE:1xSdAp:bUNkw1V9OUBMh6C52jNtqvGvFFfOrGAUEYyfARYjVu0','2026-11-29 16:33:47.614664'),('djps2z2921yjw4l0s75t6jy67an52xqm','.eJxVjDkOwjAQAP-yNbJ8HynpeYNle9c4gBwpTirE31GkFNDOjOYNMe1bi_ugNc4IE2i4_LKcypP6IfCR-n1hZenbOmd2JOy0g90WpNf1bP8GLY0GE5DMhDxQrcZ55ZNxWhQpjOLE0SpEK7L1wQXOSehUitQm6KJ4NtYqVeHzBd_vN0M:1xSdAq:4BQePLq7jJlP2MZ_yaHCBNwm033fOGEbWpd-l33VAhQ','2026-11-29 16:33:48.298223'),('km0gbl6otxtfydcn54n7uhruze0ebx4q','.eJxVjDkOwjAQAP-yNbJ8HynpeYNle9c4gBwpTirE31GkFNDOjOYNMe1bi_ugNc4IE2i4_LKcypP6IfCR-n1hZenbOmd2JOy0g90WpNf1bP8GLY0GE5DMhDxQrcZ55ZNxWhQpjOLE0SpEK7L1wQXOSehUitQm6KJ4NtYqVeHzBd_vN0M:1xSdOW:ei-dfZIkaUTTmk4xcrZPtqbKVkZJ97CxAb5ZW1fdjeY','2026-11-29 16:47:56.600544');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiencias_categoria`
--

DROP TABLE IF EXISTS `experiencias_categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencias_categoria` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `activo` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `nombre` (`nombre`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencias_categoria`
--

LOCK TABLES `experiencias_categoria` WRITE;
/*!40000 ALTER TABLE `experiencias_categoria` DISABLE KEYS */;
INSERT INTO `experiencias_categoria` VALUES (1,'Trekking','Senderos y caminatas por la reserva.',1),(2,'Canopy','Experiencias de altura en el parque.',1),(3,'Kayak','Navegación y actividades en el agua.',1),(4,'Equipos','Arriendo de equipos para actividades.',1);
/*!40000 ALTER TABLE `experiencias_categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiencias_experiencia`
--

DROP TABLE IF EXISTS `experiencias_experiencia`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencias_experiencia` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `titulo` varchar(150) COLLATE utf8mb4_unicode_ci NOT NULL,
  `descripcion` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `cupo_maximo` int unsigned NOT NULL,
  `fecha_hora` datetime(6) NOT NULL,
  `activo` tinyint(1) NOT NULL,
  `categoria_id` bigint NOT NULL,
  `creador_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `experiencias_experie_categoria_id_b03f452f_fk_experienc` (`categoria_id`),
  KEY `experiencias_experie_creador_id_70b19025_fk_cuentas_u` (`creador_id`),
  CONSTRAINT `experiencias_experie_categoria_id_b03f452f_fk_experienc` FOREIGN KEY (`categoria_id`) REFERENCES `experiencias_categoria` (`id`),
  CONSTRAINT `experiencias_experie_creador_id_70b19025_fk_cuentas_u` FOREIGN KEY (`creador_id`) REFERENCES `cuentas_usuario` (`id`),
  CONSTRAINT `experiencias_experiencia_chk_1` CHECK ((`cupo_maximo` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencias_experiencia`
--

LOCK TABLES `experiencias_experiencia` WRITE;
/*!40000 ALTER TABLE `experiencias_experiencia` DISABLE KEYS */;
INSERT INTO `experiencias_experiencia` VALUES (1,'Sendero del bosque','Senderos y caminatas por la reserva. Actividad de demostración con acompañamiento del equipo del parque.',15000.00,12,'2026-12-15 14:00:00.000000',1,1,2),(2,'Mirador del sur','Senderos y caminatas por la reserva. Actividad de demostración con acompañamiento del equipo del parque.',15000.00,12,'2026-12-16 14:00:00.000000',1,1,3),(3,'Canopy entre árboles','Experiencias de altura en el parque. Actividad de demostración con acompañamiento del equipo del parque.',20000.00,12,'2026-12-18 14:00:00.000000',1,2,2),(4,'Circuito de aventura','Experiencias de altura en el parque. Actividad de demostración con acompañamiento del equipo del parque.',20000.00,12,'2026-12-19 14:00:00.000000',1,2,3),(5,'Kayak al amanecer','Navegación y actividades en el agua. Actividad de demostración con acompañamiento del equipo del parque.',25000.00,12,'2026-12-21 14:00:00.000000',1,3,2),(6,'Travesía de la laguna','Navegación y actividades en el agua. Actividad de demostración con acompañamiento del equipo del parque.',25000.00,12,'2026-12-22 14:00:00.000000',1,3,3),(7,'Equipo de trekking','Arriendo de equipos para actividades. Actividad de demostración con acompañamiento del equipo del parque.',30000.00,12,'2026-12-24 14:00:00.000000',1,4,2),(8,'Equipo de exploración','Arriendo de equipos para actividades. Actividad de demostración con acompañamiento del equipo del parque.',30000.00,12,'2026-12-25 14:00:00.000000',1,4,3),(9,'a','a',1.29,1,'2026-11-22 16:46:00.000000',1,4,2);
/*!40000 ALTER TABLE `experiencias_experiencia` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `experiencias_reserva`
--

DROP TABLE IF EXISTS `experiencias_reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `experiencias_reserva` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `fecha_inscripcion` datetime(6) NOT NULL,
  `estado_pago` varchar(10) COLLATE utf8mb4_unicode_ci NOT NULL,
  `experiencia_id` bigint NOT NULL,
  `usuario_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `reserva_unica_usuario_experiencia` (`usuario_id`,`experiencia_id`),
  KEY `experiencias_reserva_experiencia_id_ca702f09_fk_experienc` (`experiencia_id`),
  CONSTRAINT `experiencias_reserva_experiencia_id_ca702f09_fk_experienc` FOREIGN KEY (`experiencia_id`) REFERENCES `experiencias_experiencia` (`id`),
  CONSTRAINT `experiencias_reserva_usuario_id_8724df18_fk_cuentas_usuario_id` FOREIGN KEY (`usuario_id`) REFERENCES `cuentas_usuario` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `experiencias_reserva`
--

LOCK TABLES `experiencias_reserva` WRITE;
/*!40000 ALTER TABLE `experiencias_reserva` DISABLE KEYS */;
INSERT INTO `experiencias_reserva` VALUES (1,'2026-11-15 16:33:22.164445','confirmado',1,4),(2,'2026-11-15 16:33:22.165229','pendiente',2,4),(3,'2026-11-15 16:33:22.165956','pendiente',3,4),(4,'2026-11-15 16:33:22.166674','confirmado',1,5),(5,'2026-11-15 16:33:22.167379','pendiente',2,5),(6,'2026-11-15 16:33:22.168087','pendiente',3,5);
/*!40000 ALTER TABLE `experiencias_reserva` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-11-15 13:56:32
